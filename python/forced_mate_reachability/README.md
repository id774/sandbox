# Forced Mate Reachability

## Purpose

This standalone Python experiment compares the existence of a path to a mate
terminal with the ability of an attacker to force mate against every legal
defender response. It models a fixed finite-state game derived from the
distinction in [Three-Dimensional Shogi and Forced Mate](https://blog.id774.net/entry/2026/10/27/5822/).
No three-dimensional board or move generator is implemented.

## Requirements

- Python 3.10 or later (verified with Python 3.13.5)
- Python standard library only
- Python assertions enabled (do not use `-O`)

## Run

From the repository root:

```sh
python3 -B python/forced_mate_reachability/forced_mate.py
```

Expected standard output:

```text
A0: reachable=True, forced=True
A3: reachable=True, forced=False
D2: reachable=True, forced=False
A4: reachable=False, forced=False
winning: A0, A1, A2, A5, D1, M
ranks: A0=3, A1=1, A2=1, A5=1, D1=2, M=0
all assertions passed
```

Successful execution exits with status 0 and no standard error. Failed
assertions or unhandled errors exit nonzero. The program takes no command-line
options, reads no files or standard input, makes no network requests, and
does not intentionally write files.

## Fixed Scenarios and Checks

The graph has 10 states and 11 directed edges. `A0`, `A1`, `A2`, `A3`,
`A4`, and `A5` are attacker turns; `D1` and `D2` are defender turns.
`M` is a mate terminal and `E` is a different terminal; neither terminal
has a turn. Nonterminal edges alternate the moving side.

`reachable_mate` searches for at least one path to `M`, ignoring which
side controls each decision. `forced_mate` starts with `{"M"}` and repeatedly
adds an attacker state if at least one successor is winning, or a defender
state if it has successors and all are winning. Newly accepted states are
added together at the end of each iteration.

The resulting winning set is `{M, A1, A2, A5, D1, A0}` with ranks
`M=0`, `A1=1`, `A2=1`, `A5=1`, `D1=2`, and `A0=3`. The rank is the minimum
worst-case upper bound on transitions to `M` within this fixed graph.
`A3` and `D2` can reach `M` along a path but do not force mate, because
the defender can choose the `A3`-`D2` cycle. `A4` and `E` cannot reach `M`.

Embedded assertions check graph size and references, alternating turns,
terminal classification, expected reachability and winning results, and
strictly decreasing ranks for forced-mate continuations.

## Scope and Limitations

Every edge is a pre-enumerated legal state transition. This experiment
does not generate legal moves, verify checks on an actual shogi board,
model captures, promotion, holdings, three-dimensional piece movement,
or adjudicate history-dependent rules. It does not establish the outcome
of an actual game of three-dimensional shogi.

## Files

- `forced_mate.py`: fixed state graph, reachability search, retrograde
  forced-mate calculation, embedded assertions, and deterministic output.
