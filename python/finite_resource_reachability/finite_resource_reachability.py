# finite_resource_reachability.py: Examine finite-resource computation examples
#
# Description:
# Check exact resource bounds for exhaustive key search and explicit integer
# output, then generate and verify proofs in a small illustrative system.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 finite_resource_reachability.py
#
# Requirements:
# - Python 3.12 or later
# - Only the Python standard library is required

from fractions import Fraction
from io import BytesIO


SECONDS_PER_YEAR = 365 * 24 * 60 * 60


def require(condition, message):
    if not condition:
        raise AssertionError(message)


def check_key_search():
    key_count = 1 << 256
    trials_per_second = 10**12

    worst_years = Fraction(
        key_count, trials_per_second * SECONDS_PER_YEAR
    )
    one_year_fraction = Fraction(
        trials_per_second * SECONDS_PER_YEAR, key_count
    )

    require(
        f"{float(worst_years):.3e}" == "3.672e+57",
        "Incorrect worst-case search time",
    )
    require(
        f"{float(one_year_fraction):.3e}" == "2.724e-58",
        "Incorrect one-year search fraction",
    )

    # Equality-oracle search, not an AES implementation or benchmark.
    attempts = []
    for secret in range(1 << 8):
        for candidate in range(1 << 8):
            if candidate == secret:
                attempts.append(candidate + 1)
                break

    require(max(attempts) == 256, "Incorrect worst-case trial count")
    require(
        Fraction(sum(attempts), len(attempts)) == Fraction(257, 2),
        "Incorrect mean trial count",
    )

    print(f"256-bit key space: {key_count} candidates")
    print(f"Worst-case search at 10^12 trials/s: {float(worst_years):.3e} years")
    print(f"Fraction searched in one year: {float(one_year_fraction):.3e}")
    print("8-bit toy search: worst=256 trials, mean=128.5 trials")


def check_large_integer():
    exponent = 1 << 100
    bit_length = exponent + 1
    byte_length = (bit_length + 7) // 8

    require(
        bit_length == 1267650600228229401496703205377,
        "Incorrect binary representation length",
    )
    require(
        byte_length == 158456325028528675187087900673,
        "Incorrect minimum byte length",
    )

    # Construct only small instances of 2**(2**k).
    for k in (0, 1, 2, 4, 8, 12, 16):
        number = 1 << (1 << k)
        expected_bits = (1 << k) + 1
        expected_bytes = (expected_bits + 7) // 8

        require(
            number.bit_length() == expected_bits,
            f"Incorrect bit length at k={k}",
        )
        require(
            len(number.to_bytes(expected_bytes, "big")) == expected_bytes,
            f"Incorrect byte length at k={k}",
        )

    bytes_per_second = 10**12
    minimum_output_years = Fraction(
        byte_length, bytes_per_second * SECONDS_PER_YEAR
    )

    print(f"2**(2**100) binary length: {bit_length} bits")
    print(f"Minimum packed storage: {byte_length} bytes")
    print(
        "Minimum output time at 10^12 bytes/s: "
        f"{float(minimum_output_years):.3e} years"
    )
    print("Small-instance representation checks: PASS")


def make_toy_proof(target):
    # Axiom P(0), inference rule P(i) -> P(i+1).
    return b"".join(
        f"P({i})\n".encode("ascii")
        for i in range(target + 1)
    )


def verify_toy_proof(stream):
    lines_read = 0
    bytes_read = 0

    for expected, line in enumerate(stream):
        bytes_read += len(line)

        if line != f"P({expected})\n".encode("ascii"):
            return False, lines_read, bytes_read

        lines_read += 1

    return lines_read > 0, lines_read, bytes_read


def check_proof():
    for target in (100, 1_000, 10_000):
        proof = make_toy_proof(target)
        valid, lines_read, bytes_read = verify_toy_proof(BytesIO(proof))

        require(valid, f"Valid proof P({target}) was rejected")
        require(
            lines_read == target + 1,
            f"Incorrect proof line count for P({target})",
        )
        require(
            bytes_read == len(proof),
            f"Incorrect proof byte count for P({target})",
        )

        print(
            f"Toy proof P({target}): "
            f"{lines_read} lines, {bytes_read} bytes, verified"
        )

    proof = make_toy_proof(20)
    corrupted = proof.replace(b"P(10)\n", b"P(99)\n", 1)

    valid, _, _ = verify_toy_proof(BytesIO(corrupted))
    require(not valid, "Corrupted proof was accepted")

    valid, _, _ = verify_toy_proof(BytesIO(b""))
    require(not valid, "Empty proof was accepted")

    print("Corrupted and empty proofs rejected: PASS")


if __name__ == "__main__":
    check_key_search()
    check_large_integer()
    check_proof()
    print("All finite-resource example checks: PASS")
