# Quantum Shogi Hall Projection

## Purpose

This standalone Python example computes the globally supported base piece kinds
for the 20 pieces belonging to one original side in quantum shogi. The eight
kinds have fixed capacities: king 1, rook 1, bishop 1, gold 2, silver 2,
knight 2, lance 2, and pawn 9. Scanning all 255 nonempty kind subsets detects
Hall capacity violations and removes candidates that are unsupported by every
complete assignment. Complete assignments are not enumerated.

## Requirements

- Python 3.12 or later
- Python standard library only

## Run

From the repository root:

```sh
python3 -B python/quantum_shogi_hall/quantum_shogi_hall.py
```

Successful execution prints exactly:

```text
候補の射影・冪等性・容量超過の検証: PASS
```

The exit status is 0 on success. A failed example assertion or any unhandled
error exits nonzero. The script has no command-line options, reads no files,
does not write files, and makes no network requests. Run without `-O`, which
would disable the `assert` statements used by the examples.

## Checks

- Three domains `{飛, 香}` exhaust one rook and two lance slots; the other
  17 domains lose those two kinds.
- Fixing one of those three domains to `{飛}` reduces the other two to `{香}`.
- Four domains `{飛, 香}` exceed the three available slots and raise
  `ValueError` with the Hall capacity violation message.
- Projecting a feasible result again leaves it unchanged.

## Scope

`project` accepts 20 eight-bit candidate masks and returns 20 masks after
exact capacity-based projection. It rejects an incorrect number of pieces,
empty or out-of-range masks, and Hall capacity violations by raising
`ValueError`. The model applies to basic kind assignments for one initial
side, not to board movement, promotion, captures, move legality, or gameplay.
