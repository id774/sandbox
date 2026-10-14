# analyze.py: Trace recorded upstream transfers of personal data
#
# Description:
# Identify datasets recorded on a selected system and follow the recorded
# transfer paths upstream to their source systems and operators.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     cd python/personal_data_impact_trace
#     python3 analyze.py --system subship
#     python3 analyze.py --system subship --data-dir .
#
# Requirements:
# - Python 3.12 or later
# - Only the Python standard library is required

import argparse
import csv
import json
from collections import defaultdict, deque
from pathlib import Path


INVENTORY_COLUMNS = ["system", "operator", "dataset", "subjects", "data_type"]
TRANSFER_COLUMNS = ["dataset", "src", "dst"]


def read_csv(path, columns):
    with path.open(encoding="utf-8", newline="") as file:
        reader = csv.DictReader(file)
        if reader.fieldnames != columns:
            raise ValueError(f"{path.name}: expected columns {columns}")
        rows = list(reader)
    for number, row in enumerate(rows, start=2):
        if None in row or any(value is None or not value.strip() for value in row.values()):
            raise ValueError(f"{path.name}:{number}: invalid row")
    return rows


def analyze(directory, compromised):
    inventory = read_csv(directory / "inventory.csv", INVENTORY_COLUMNS)
    transfers = read_csv(directory / "transfers.csv", TRANSFER_COLUMNS)

    by_key = {}
    attributes = {}
    for row in inventory:
        key = (row["system"], row["dataset"])
        if key in by_key:
            raise ValueError(f"duplicate inventory entry: {key}")
        by_key[key] = row
        dataset = row["dataset"]
        value = (row["subjects"], row["data_type"])
        if dataset in attributes and attributes[dataset] != value:
            raise ValueError(f"inconsistent dataset attributes: {dataset}")
        attributes[dataset] = value

    if compromised not in {row["system"] for row in inventory}:
        raise ValueError(f"unknown system: {compromised}")

    reverse = defaultdict(list)
    for row in transfers:
        dataset, src, dst = row["dataset"], row["src"], row["dst"]
        if (src, dataset) not in by_key or (dst, dataset) not in by_key:
            raise ValueError(f"transfer endpoint missing from inventory: {dataset}:{src}->{dst}")
        reverse[(dataset, dst)].append(src)

    results = []
    for (system, dataset), row in sorted(by_key.items()):
        if system != compromised:
            continue
        visited = {compromised}
        edges = set()
        queue = deque([compromised])
        while queue:
            dst = queue.popleft()
            for src in reverse[(dataset, dst)]:
                edges.add((src, dst))
                if src not in visited:
                    visited.add(src)
                    queue.append(src)
        results.append({
            "dataset": dataset,
            "subjects": row["subjects"],
            "data_type": row["data_type"],
            "related_systems": sorted(visited),
            "related_operators": sorted({by_key[(system_id, dataset)]["operator"] for system_id in visited}),
            "transfers": [{"src": src, "dst": dst} for src, dst in sorted(edges)],
        })
    return results


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--system", required=True)
    parser.add_argument("--data-dir", type=Path, default=Path("."))
    args = parser.parse_args()
    try:
        results = analyze(args.data_dir, args.system)
    except (OSError, ValueError, csv.Error) as error:
        parser.exit(2, f"ERROR: {error}\n")
    print(json.dumps(results, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
