# sqlite-vec

A small, deterministic sample of binary quantization with
[sqlite-vec](https://github.com/asg017/sqlite-vec), the SQLite extension for
vector search.

## Sample

`binary_quantization.py` keeps five fixed 8-dimensional float32 vectors in an
in-memory SQLite database, in a `vec0` virtual table with two columns: the
original `float[8]` vector and a `bit[8]` column filled with
`vec_quantize_binary()`.

Binary quantization keeps only the sign of each element: a positive element
becomes 1 and the others become 0. A float32 element takes 32 bits and a
quantized one takes 1 bit, so a bit vector is 32 times smaller in theory. The
number of dimensions must be a multiple of 8.

Bit vectors are compared by Hamming distance, the number of differing bits. The
sample uses it as a coarse search: it takes the 3 nearest rows by Hamming
distance, then reranks only those rows by L2 distance on the original float32
vectors, and checks that the expected row comes out first. Two rows share the
query's signs, so the coarse search cannot separate them and the float32 rerank
decides.

The sample prints the SQLite and sqlite-vec versions, the vector sizes in
bytes, the theoretical 32x ratio, and both result lists. It does not measure
speed or recall, so it makes no claim about the speedup of the technique.

## Requirements

Python 3.10 or later, built with SQLite extension loading enabled, and the
library in `requirements.txt`:

    pip install -r requirements.txt

## Run

    ./binary_quantization.py

The script exits with a non-zero status when a check fails.

## References

- [sqlite-vec v0.1.9 release](https://github.com/asg017/sqlite-vec/releases/tag/v0.1.9)
- [Binary quantization guide](https://github.com/asg017/sqlite-vec/blob/v0.1.9/site/guides/binary-quant.md)
- [API reference](https://github.com/asg017/sqlite-vec/blob/v0.1.9/site/api-reference.md)

The sample was inspired by a
[Qiita article](https://qiita.com/0h-n0/items/2b270174796b2fd22042).
