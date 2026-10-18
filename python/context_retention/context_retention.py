# context_retention.py: Compare retention of required agent history under character limits
#
# Description:
# Compare newest-first and required-first selection of immutable history
# records under fixed character capacities, including an infeasible budget.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 -B python/context_retention/context_retention.py
#
# Requirements:
# - Python 3.11 or later
# - Python standard library only
# - No command-line arguments or external data files
#
from dataclasses import dataclass


@dataclass(frozen=True)
class Record:
    id: int
    text: str
    required: bool = False


HISTORY = [
    Record(1, "本番環境への書き込みは担当者の承認後に実行する", True),
    Record(2, "リポジトリの構成を調査し、主要なディレクトリを列挙した"),
    Record(3, "作業対象は設定ファイル一つに限定する", True),
    Record(4, "既存のテスト一覧を取得した"),
    Record(5, "依存ライブラリのバージョンを確認した"),
    Record(6, "既存のエラーメッセージの文字列は変更しない", True),
    Record(7, "検証用の一時ディレクトリを作成した"),
    Record(8, "一度目のテストでは想定と異なる終了コードが返った"),
    Record(9, "検証は外部サービスへの通信を使わずローカルで完結させる", True),
    Record(10, "失敗の原因をテスト入力の順序に絞って確認した"),
    Record(11, "修正後の単体テストがすべて成功した"),
    Record(12, "最終的に変更ファイルの一覧を取得した"),
]


def length(records: list[Record]) -> int:
    return len("\n".join(record.text for record in records))


def recent_first(records: list[Record], capacity: int) -> list[Record]:
    selected: list[Record] = []
    for record in reversed(records):
        candidate = [record, *selected]
        if length(candidate) > capacity:
            break
        selected = candidate
    return selected


def required_first(records: list[Record], capacity: int) -> list[Record]:
    selected = [record for record in records if record.required]
    if length(selected) > capacity:
        raise ValueError("required records exceed capacity")

    for record in reversed(records):
        if record.required:
            continue
        candidate = sorted([*selected, record], key=lambda item: item.id)
        if length(candidate) > capacity:
            break
        selected = candidate
    return selected


def rates(original: list[Record], selected: list[Record]) -> tuple[float, float, float]:
    required_ids = {record.id for record in original if record.required}
    selected_ids = {record.id for record in selected}
    original_text = {record.id: record.text for record in original}
    reduction = 1 - length(selected) / length(original)
    retention = len(required_ids & selected_ids) / len(required_ids)
    fidelity = (
        sum(record.text == original_text[record.id] for record in selected) / len(selected)
        if selected else 1.0
    )
    return reduction, retention, fidelity


def main() -> None:
    total = length(HISTORY)
    required = [record for record in HISTORY if record.required]
    print(f"original={total} chars; required_min={length(required)} chars")
    print("budget  method    used  reduction  required  exact")
    for percentage in (100, 70, 50, 25):
        capacity = total * percentage // 100
        for label, selector in (("recent", recent_first), ("required", required_first)):
            try:
                selected = selector(HISTORY, capacity)
            except ValueError:
                print(f"{percentage:>3}%    {label:<8}  INFEASIBLE (required records exceed capacity)")
                continue
            reduction, retention, fidelity = rates(HISTORY, selected)
            print(
                f"{percentage:>3}%    {label:<8}  {length(selected):>4}  "
                f"{reduction:>8.1%}  {retention:>8.1%}  {fidelity:>5.1%}"
            )


if __name__ == "__main__":
    main()
