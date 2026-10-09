#!/usr/bin/env python3
# elliptic_curve_points.py: Point counts and local-factor denominators
#
# Description:
# Count points on y^2 = x^3 - x over four small prime fields and calculate
# the Frobenius traces and denominators of the corresponding local factors.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 python/math/elliptic_curve_points.py
#
# Requirements:
# - Python 3.6 or later
# - No third-party package is required

PRIMES = (5, 7, 11, 13)
EXPECTED = {
    5: (8, -2),
    7: (8, 0),
    11: (12, 0),
    13: (8, 6),
}


def count_points(p):
    # Include the point at infinity in addition to the affine points.
    return 1 + sum(
        (y * y - (x * x * x - x)) % p == 0
        for x in range(p)
        for y in range(p)
    )


def local_denominator(p, a_p):
    # Format the polynomial 1 - a_p*T + p*T^2.
    if a_p < 0:
        return f"1 + {-a_p}T + {p}T^2"
    if a_p > 0:
        return f"1 - {a_p}T + {p}T^2"
    return f"1 + {p}T^2"


def main():
    print("p   #E(F_p)   a_p   local denominator")
    for p in PRIMES:
        point_count = count_points(p)
        a_p = p + 1 - point_count

        # Check both the fixed reference values and the Hasse bound.
        assert (point_count, a_p) == EXPECTED[p], (p, point_count, a_p)
        assert a_p * a_p <= 4 * p, (p, a_p)

        print(f"{p:<3} {point_count:>7} {a_p:>5}   {local_denominator(p, a_p)}")


if __name__ == "__main__":
    main()
