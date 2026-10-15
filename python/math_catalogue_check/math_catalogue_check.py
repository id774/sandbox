# math_catalogue_check.py: Check mathematics manuscripts and Lean metadata
#
# Description:
# Check published manuscript and result-family counts against the manuscript
# map, and report Lean formalization catalogue metadata and unmatched paths.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   Copy this file into the root of a checked-out openai/math repository.
#   python math_catalogue_check.py
#
# Requirements:
# - Python 3.12 or later
# - PyYAML 6.0.3

from pathlib import Path
import re

import yaml

FAMILY_PATTERN = re.compile(r"^\*\*(\d{3})\.", re.MULTILINE)
PAPER_PATTERN = re.compile(
    r"^[ \t]*&emsp;\[[^\n]+\]\((preprints/[^)\n]+)\)", re.MULTILINE
)
README_PATTERN = re.compile(
    r"current catalogue contains (\d+) manuscripts organized into (\d+) families"
)
HISTORY_PATTERN = re.compile(r"(\d+)\s*/\s*(\d+)\s*=\s*~(\d+)%")


def check_unique(name, values):
    if len(values) != len(set(values)):
        raise ValueError(f"duplicate {name}")


def main():
    root = Path(__file__).resolve().parent
    readme = (root / "README.md").read_text(encoding="utf-8")
    contents = (root / "CONTENTS.md").read_text(encoding="utf-8")
    history = (root / "history.md").read_text(encoding="utf-8")
    with (root / "lean/formalization.yaml").open(encoding="utf-8") as f:
        catalogue = yaml.safe_load(f)

    families = FAMILY_PATTERN.findall(contents)
    papers = PAPER_PATTERN.findall(contents)
    check_unique("family numbers", families)
    check_unique("manuscript paths", papers)

    published = README_PATTERN.search(readme)
    if published is None:
        raise ValueError("README catalogue counts not found")
    claimed_papers, claimed_families = map(int, published.groups())
    if (len(papers), len(families)) != (claimed_papers, claimed_families):
        raise ValueError("README and CONTENTS.md counts disagree")

    sources = catalogue["sources"]
    results = catalogue["status"]["main_results"]
    source_paths = []
    for source in sources:
        path = source["id"]
        if not isinstance(path, str) or not path.startswith("../preprints/"):
            raise ValueError(f"unexpected source path: {path}")
        source_paths.append(path.removeprefix("../"))
    check_unique("source paths", source_paths)

    declarations = []
    for result in results:
        for key in ("declaration", "file", "comparator_config"):
            if not isinstance(result.get(key), str) or not result[key]:
                raise ValueError(f"missing or invalid main-result field: {key}")
        declarations.append(result["declaration"])
    check_unique("Lean declarations", declarations)

    report = HISTORY_PATTERN.search(history)
    if report is None:
        raise ValueError("history formalization ratio not found")
    reported_formalized, reported_total, reported_percent = map(int, report.groups())
    if reported_total != len(papers):
        raise ValueError("history denominator and manuscript count disagree")

    unmatched = sorted(set(source_paths) - set(papers))
    print(f"result_families: {len(families)}")
    print(f"manuscripts: {len(papers)}")
    print(f"formalization_sources: {len(sources)}")
    print(f"main_result_declarations: {len(results)}")
    print(f"unmatched_source_paths: {len(unmatched)}")
    for path in unmatched:
        print(f"  {path}")
    print(
        "reported_formalized_top_line_results: "
        f"{reported_formalized}/{reported_total} (~{reported_percent}%)"
    )
    print(f"yaml_scope: {catalogue['status']['scope']}")
    print(f"yaml_review: {catalogue['review']['status']}")


if __name__ == "__main__":
    main()
