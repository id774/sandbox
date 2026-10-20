# citation_contract.py: Verify citations against independently reviewed source evidence
#
# Description:
# Validate claim IDs, citation IDs, and SHA-256-bound independent support
# reviews before accepting a cited answer.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage (from repository root):
#     python3 -B python/citation_contract/citation_contract.py python/citation_contract/answer.json python/citation_contract/sources.json python/citation_contract/reviews.json
#
# Requirements:
# - Python 3.13 or later
# - Python standard library only
# - Three UTF-8 JSON input files
#
import argparse
import hashlib
import json
import re


ID_PATTERN = re.compile(r"[A-Za-z0-9][A-Za-z0-9_-]*\Z")
HASH_PATTERN = re.compile(r"[0-9a-f]{64}\Z")


def records(document, key, fields):
    if type(document) is not dict or set(document) != {key}:
        raise ValueError(f"{key}: 最上位のキーが不正です")
    items = document[key]
    if type(items) is not list:
        raise ValueError(f"{key}: 配列が必要です")
    for index, item in enumerate(items):
        if type(item) is not dict or set(item) != fields:
            raise ValueError(f"{key}[{index}]: 項目が不正です")
    return items


def nonempty(value):
    if type(value) is not str or not value.strip():
        return False
    try:
        value.encode("utf-8")
    except UnicodeEncodeError:
        return False
    return True


def identifier(value):
    return type(value) is str and ID_PATTERN.fullmatch(value) is not None


def fingerprint(claim, source):
    target = {
        "claim_id": claim["id"],
        "claim_text": claim["text"],
        "citation_id": claim["citation_id"],
        "source_content": source["content"],
    }
    payload = json.dumps(
        target, ensure_ascii=False, sort_keys=True, separators=(",", ":")
    ).encode("utf-8")
    return hashlib.sha256(payload).hexdigest()


def evaluate(answer, sources, reviews):
    try:
        claims = records(answer, "claims", {"id", "text", "citation_id"})
        documents = records(sources, "sources", {"id", "content"})
        checks = records(reviews, "reviews", {"claim_id", "fingerprint", "verdict"})

        if not claims:
            raise ValueError("claims: 主張が空です")
        for claim in claims:
            if not (identifier(claim["id"]) and nonempty(claim["text"])
                    and identifier(claim["citation_id"])):
                raise ValueError("claims: 主張または引用 ID が不正です")
        for document in documents:
            if not (identifier(document["id"]) and nonempty(document["content"])):
                raise ValueError("sources: 資料が不正です")
        for check in checks:
            if not (identifier(check["claim_id"])
                    and type(check["fingerprint"]) is str
                    and HASH_PATTERN.fullmatch(check["fingerprint"])
                    and check["verdict"] in ("supported", "unsupported")):
                raise ValueError("reviews: 確認結果が不正です")

        for values, key, label in (
            (claims, "id", "claims"),
            (documents, "id", "sources"),
            (checks, "claim_id", "reviews"),
        ):
            identifiers = [item[key] for item in values]
            if len(identifiers) != len(set(identifiers)):
                raise ValueError(f"{label}: ID が重複しています")

        source_by_id = {item["id"]: item for item in documents}
        claim_ids = {item["id"] for item in claims}
        if any(item["citation_id"] not in source_by_id for item in claims):
            raise ValueError("claims: 今回取得した資料にない引用 ID があります")
        if any(item["claim_id"] not in claim_ids for item in checks):
            raise ValueError("reviews: 存在しない主張 ID があります")
    except ValueError as exc:
        return "REJECT", [str(exc)]

    check_by_id = {item["claim_id"]: item for item in checks}
    rejected = []
    pending = []
    for claim in claims:
        review = check_by_id.get(claim["id"])
        if review is None:
            pending.append(f"{claim['id']}: 根拠確認が未実施です")
        elif review["fingerprint"] != fingerprint(
            claim, source_by_id[claim["citation_id"]]
        ):
            pending.append(f"{claim['id']}: 確認対象の内容が一致しません")
        elif review["verdict"] == "unsupported":
            rejected.append(f"{claim['id']}: 引用資料が主張を支持しません")

    if rejected:
        return "REJECT", rejected + pending
    if pending:
        return "REVIEW", pending
    return "ACCEPT", ["すべての主張について支持確認が完了しました"]


def main():
    parser = argparse.ArgumentParser(description="引用の検証契約を判定します")
    parser.add_argument("answer")
    parser.add_argument("sources")
    parser.add_argument("reviews")
    args = parser.parse_args()
    try:
        documents = []
        for path in (args.answer, args.sources, args.reviews):
            with open(path, encoding="utf-8") as stream:
                documents.append(json.load(stream))
    except (OSError, UnicodeDecodeError, json.JSONDecodeError) as exc:
        parser.error(str(exc))
    status, reasons = evaluate(*documents)
    print(json.dumps({"status": status, "reasons": reasons}, ensure_ascii=False, indent=2))
    return 0 if status == "ACCEPT" else 1


if __name__ == "__main__":
    raise SystemExit(main())
