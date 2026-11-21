# attribute_leakage.py: Measure attribute identification from message wording
#
# Description:
# Simulate meeting messages under synthetic attribute labels and compare
# total variation and identification accuracy across four fixed conditions.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
# python3 -B python/attribute_leakage/attribute_leakage.py
#
# Requirements:
# - Python 3.12 or 3.13, with assertions enabled
# - Python standard library only
# - No command-line arguments or external data files

from collections import Counter
from dataclasses import dataclass
from random import Random
from statistics import mean

SEED = 20261121
N_PER_LABEL = 200
N_TRAIN_PER_LABEL = 160

MESSAGE_HEADER = (
    "件名：会議のご案内\n"
    "日時：12月3日 14時\n"
    "場所：第2会議室\n"
)
ENDING = (
    "会議へのご参加をお願いします。",
    "会議にご出席ください。",
)


@dataclass(frozen=True)
class Row:
    label: int
    feature: int
    message: str


def generate(seed, p_one_given_label):
    rng = Random(seed)
    rows = []
    for label in (0, 1):
        for _ in range(N_PER_LABEL):
            feature = int(rng.random() < p_one_given_label[label])
            rows.append(Row(label, feature, MESSAGE_HEADER + ENDING[feature]))
    rng.shuffle(rows)
    return rows


def split_balanced(rows):
    by_label = {label: [] for label in (0, 1)}
    for row in rows:
        by_label[row.label].append(row)
    assert all(len(by_label[label]) == N_PER_LABEL for label in (0, 1))
    train = sum((by_label[label][:N_TRAIN_PER_LABEL] for label in (0, 1)), [])
    test = sum((by_label[label][N_TRAIN_PER_LABEL:] for label in (0, 1)), [])
    return train, test


def extracted_feature(message):
    hits = [index for index, ending in enumerate(ENDING) if message.endswith(ending)]
    if len(hits) != 1 or not message.startswith(MESSAGE_HEADER):
        raise ValueError("Unexpected message format")
    return hits[0]


def fit(train):
    counts = Counter((extracted_feature(row.message), row.label) for row in train)
    # Break ties in favor of label 0; evaluate only on held-out records.
    return {z: int(counts[z, 1] > counts[z, 0]) for z in (0, 1)}


def evaluate(test, rule):
    confusion = [[0, 0], [0, 0]]  # Rows: true labels; columns: predicted labels
    for row in test:
        pred = rule[extracted_feature(row.message)]
        confusion[row.label][pred] += 1
    correct = confusion[0][0] + confusion[1][1]
    return correct / len(test), confusion


def empirical_tv(rows):
    by_label = Counter((row.label, extracted_feature(row.message)) for row in rows)
    return 0.5 * sum(
        abs(by_label[0, z] / N_PER_LABEL - by_label[1, z] / N_PER_LABEL)
        for z in (0, 1)
    )


def permute_labels(rows, seed):
    rng = Random(seed)
    labels = [row.label for row in rows]
    rng.shuffle(labels)
    return [Row(label, row.feature, row.message) for row, label in zip(rows, labels)]


def standardize_messages(rows):
    return [Row(row.label, 0, MESSAGE_HEADER + ENDING[0]) for row in rows]


def run_once(seed, probabilities, treatment="original"):
    rows = generate(seed, probabilities)
    if treatment == "permuted":
        rows = permute_labels(rows, seed + 1000000)
    elif treatment == "standardized":
        rows = standardize_messages(rows)
    elif treatment != "original":
        raise ValueError(treatment)
    assert all(row.feature == extracted_feature(row.message) for row in rows)
    assert all(row.message.startswith(MESSAGE_HEADER) for row in rows)
    train, test = split_balanced(rows)
    assert len(train) == 320 and len(test) == 80
    assert Counter(row.label for row in test) == {0: 40, 1: 40}
    rule = fit(train)
    accuracy, confusion = evaluate(test, rule)
    return empirical_tv(rows), accuracy, confusion, rule


def print_one(title, seed, probabilities, treatment="original"):
    tv, accuracy, confusion, rule = run_once(seed, probabilities, treatment)
    theoretical_tv = abs(probabilities[1] - probabilities[0]) if treatment == "original" else 0.0
    theoretical_acc = (1.0 + theoretical_tv) / 2.0
    print(f"{title}")
    print(f"  理論 TV={theoretical_tv:.3f}, 理論最適正答率={theoretical_acc:.1%}")
    print(f"  観測 TV={tv:.3f}, 評価正答率={accuracy:.1%}, 識別規則={rule}")
    print(f"  混同行列 [[{confusion[0][0]}, {confusion[0][1]}], "
          f"[{confusion[1][0]}, {confusion[1][1]}]]")
    return accuracy


def main():
    scenarios = (
        ("非依存", (0.5, 0.5), "original"),
        ("属性依存", (0.2, 0.8), "original"),
        ("ラベル置換", (0.2, 0.8), "permuted"),
        ("表現統一", (0.2, 0.8), "standardized"),
    )
    print(f"合成データ: 400 件、学習: 320 件、評価: 80 件、seed={SEED}")
    print("基準正答率: 50.0% （評価用ラベルが各 40 件）")
    for title, probabilities, treatment in scenarios:
        print_one(title, SEED, probabilities, treatment)
    print("50 種類の seed による評価正答率（同じ実験条件で再生成）")
    for title, probabilities, treatment in scenarios:
        accuracies = [run_once(SEED + i, probabilities, treatment)[1] for i in range(50)]
        print(f"  {title}: 平均={mean(accuracies):.1%}, "
              f"最小={min(accuracies):.1%}, 最大={max(accuracies):.1%}")


if __name__ == "__main__":
    main()
