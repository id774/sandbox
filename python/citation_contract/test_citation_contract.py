# test_citation_contract.py: Unit tests for citation verification decisions
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Run (from repository root):
#     python3 -B -m unittest discover -s python/citation_contract -p 'test_*.py' -v
#
# Requirements:
# - Python 3.13 or later
# - Python standard library only
#
import copy
import unittest

from citation_contract import evaluate, fingerprint


def fixture():
    answer = {"claims": [
        {"id": "C1", "text": "検証環境の API は HTTP 200 を返しました。", "citation_id": "S1"}
    ]}
    sources = {"sources": [
        {"id": "S1", "content": "実行ログ: 検証環境の API は HTTP 200 を返しました。"}
    ]}
    reviews = {"reviews": [
        {"claim_id": "C1", "fingerprint": fingerprint(
            answer["claims"][0], sources["sources"][0]
        ), "verdict": "supported"}
    ]}
    return answer, sources, reviews


class CitationContractTests(unittest.TestCase):
    def test_t1_all_supported(self):
        self.assertEqual(evaluate(*fixture())[0], "ACCEPT")

    def test_t2_no_review(self):
        answer, sources, reviews = fixture()
        reviews["reviews"] = []
        self.assertEqual(evaluate(answer, sources, reviews)[0], "REVIEW")

    def test_t3_missing_source(self):
        answer, sources, reviews = fixture()
        answer["claims"][0]["citation_id"] = "S9"
        self.assertEqual(evaluate(answer, sources, reviews)[0], "REJECT")

    def test_t4_no_citation(self):
        answer, sources, reviews = fixture()
        answer["claims"][0]["citation_id"] = ""
        self.assertEqual(evaluate(answer, sources, reviews)[0], "REJECT")

    def test_t5_unsupported(self):
        answer, sources, reviews = fixture()
        reviews["reviews"][0]["verdict"] = "unsupported"
        self.assertEqual(evaluate(answer, sources, reviews)[0], "REJECT")

    def test_t6_some_unreviewed(self):
        answer, sources, reviews = fixture()
        answer["claims"].append({
            "id": "C2", "text": "別の主張です。", "citation_id": "S1"
        })
        self.assertEqual(evaluate(answer, sources, reviews)[0], "REVIEW")

    def test_t7_reject_precedes_review(self):
        answer, sources, reviews = fixture()
        answer["claims"].append({
            "id": "C2", "text": "別の主張です。", "citation_id": "S1"
        })
        reviews["reviews"][0]["verdict"] = "unsupported"
        self.assertEqual(evaluate(answer, sources, reviews)[0], "REJECT")

    def test_t8_changed_claim_or_source(self):
        for target in ("claim", "source"):
            with self.subTest(target=target):
                answer, sources, reviews = fixture()
                if target == "claim":
                    answer["claims"][0]["text"] = "書き換えられた主張です。"
                else:
                    sources["sources"][0]["content"] = "書き換えられた資料です。"
                self.assertEqual(evaluate(answer, sources, reviews)[0], "REVIEW")

    def test_t9_malformed_or_duplicate(self):
        for variant in ("empty_text", "duplicate_claim", "invalid_review",
                        "invalid_claim_unicode", "invalid_source_unicode"):
            with self.subTest(variant=variant):
                answer, sources, reviews = fixture()
                if variant == "empty_text":
                    answer["claims"][0]["text"] = " "
                elif variant == "duplicate_claim":
                    answer["claims"].append(copy.deepcopy(answer["claims"][0]))
                elif variant == "invalid_claim_unicode":
                    answer["claims"][0]["text"] = "\ud800"
                elif variant == "invalid_source_unicode":
                    sources["sources"][0]["content"] = "\ud800"
                else:
                    reviews["reviews"][0]["fingerprint"] = "bad"
                self.assertEqual(evaluate(answer, sources, reviews)[0], "REJECT")


if __name__ == "__main__":
    unittest.main()
