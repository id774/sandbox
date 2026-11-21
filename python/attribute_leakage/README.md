# Generated-Text Attribute Identification

## Purpose

This experiment uses synthetic binary labels to measure how the choice between
otherwise equivalent meeting-request phrases can reveal a label. It compares
empirical total variation distance and held-out classification accuracy for
four fixed conditions. The experiment contains no real personal data and does
not invoke a language model or external service.

## Requirements

- Python 3 interpreter, using the standard library only.
- Assertions enabled. Do not run with `-O` or `PYTHONOPTIMIZE`.
- No third-party packages, installation step, external data, or network access.
- The expected output below was measured with Python 3.13.5.

## Verified Environment

Tested with Python 3.12.16, 3.13.5, and 3.13.18.

## Run

From the repository root:

```sh
python3 -B python/attribute_leakage/attribute_leakage.py
```

The program requires no arguments and does not read or write files. It prints
four cases and a 50-seed accuracy summary to standard output. Successful
execution exits with status 0. A failed assertion or an unhandled exception
exits nonzero; earlier output may already have been printed.

## Fixed Data and Evaluation

Each run creates 200 messages for label `A=0` and 200 for label `A=1`. Every
message has the same subject, meeting time, and location, with one of two
request phrases at the end. `Z=0` and `Z=1` identify those phrases. The label
is available when creating the synthetic data and when measuring accuracy,
while the classifier extracts only `Z` from the message text.

The base seed is `20261121`. Each run splits the messages into 160 training
records and 40 held-out evaluation records per label, after shuffling.
The classifier predicts the more frequent training label for each phrase and
chooses label `0` on a tie. An always-0 classifier obtains 50% accuracy on
the balanced evaluation set.

| Case | P(Z=1 given A=0) | P(Z=1 given A=1) | Treatment |
| --- | ---: | ---: | --- |
| Independent | 0.5 | 0.5 | None |
| Dependent | 0.2 | 0.8 | None |
| Permuted labels | 0.2 | 0.8 | Shuffle label assignments after message generation |
| Standardized wording | 0.2 | 0.8 | Replace all endings with phrase 0 |

The program calculates observed total variation from all 400 messages and
classification accuracy from the held-out 80 messages. The 400-message count
is descriptive and does not train the classifier. The theoretical total
variation is `0` in the independent and standardized cases, `0.6` in the
dependent case, and `0` as the independence-null reference for permutation.
With equally likely labels, optimal accuracy is `(1 + TV) / 2`; the corresponding
reference accuracies are 50%, 80%, 50%, and 50%.

The last section repeats each case with seeds `20261121` through `20261170`
and prints mean, minimum, and maximum evaluation accuracies.

## Expected Output

The following is the exact standard output measured under Python 3.13.5:

```text
合成データ: 400 件、学習: 320 件、評価: 80 件、seed=20261121
基準正答率: 50.0% （評価用ラベルが各 40 件）
非依存
  理論 TV=0.000, 理論最適正答率=50.0%
  観測 TV=0.140, 評価正答率=56.2%, 識別規則={0: 0, 1: 1}
  混同行列 [[22, 18], [17, 23]]
属性依存
  理論 TV=0.600, 理論最適正答率=80.0%
  観測 TV=0.705, 評価正答率=87.5%, 識別規則={0: 0, 1: 1}
  混同行列 [[36, 4], [6, 34]]
ラベル置換
  理論 TV=0.000, 理論最適正答率=50.0%
  観測 TV=0.065, 評価正答率=52.5%, 識別規則={0: 0, 1: 1}
  混同行列 [[22, 18], [20, 20]]
表現統一
  理論 TV=0.000, 理論最適正答率=50.0%
  観測 TV=0.000, 評価正答率=50.0%, 識別規則={0: 0, 1: 0}
  混同行列 [[40, 0], [40, 0]]
50 種類の seed による評価正答率（同じ実験条件で再生成）
  非依存: 平均=49.2%, 最小=32.5%, 最大=58.8%
  属性依存: 平均=80.8%, 最小=68.8%, 最大=88.8%
  ラベル置換: 平均=50.3%, 最小=41.2%, 最大=62.5%
  表現統一: 平均=50.0%, 最小=50.0%, 最大=50.0%
```

## Interpretation and Limits

Finite samples can produce observed total variation and evaluation accuracy
that differ from their population or null-reference values. In the label
permutation case, `TV=0` is the reference for attribute-phrase independence;
the sampled permutation need not have an observed TV of zero. The held-out
records can contain the same two phrase strings as training records, so the
accuracy does not measure generalization to unseen phrasings.

The synthetic label is specified in advance. This experiment demonstrates
identification from controlled wording differences, not real-world inference
of private traits, real language-model behavior, or guarantees of privacy
when other textual features or encoding channels are available.

## Files

- `attribute_leakage.py`: fixed synthetic message generation, four-case
  comparison, empirical TV calculation, held-out classifier evaluation,
  and 50-seed accuracy summary.
