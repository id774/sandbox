// modpow.zig: Modular exponentiation of fixed triples by repeated squaring
//
// Description:
// Print modular powers of fixed triples, each squared and halved by repeated squaring.
//
// Part of the math cross-language exercise set: it reads no arguments or
// standard input, keeps its data fixed in the source, uses integer
// arithmetic only, and its output is the same as that of the same exercise
// in every other language. The exercises are specified in README.md at the
// repository root.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Build / Run:
//     zig build-exe modpow.zig
//     ./modpow
//
// Requirements:
// - Zig 0.16, the release these sources were written against (Zig is
//   pre-1.0, and its standard library changes between releases)
// - No third-party package is required

const std = @import("std");

const Case = struct { base: u64, exponent: u64, modulus: u64 };

const cases = [_]Case{
    .{ .base = 2, .exponent = 1000, .modulus = 1000003 },
    .{ .base = 3, .exponent = 200, .modulus = 50 },
    .{ .base = 5, .exponent = 117, .modulus = 19 },
    .{ .base = 10, .exponent = 18, .modulus = 9999991 },
};

fn modpow(base: u64, exponent: u64, modulus: u64) u64 {
    var factor = base % modulus;
    var power = exponent;
    var result: u64 = 1;

    while (power > 0) {
        if (power % 2 == 1) result = result * factor % modulus;
        factor = factor * factor % modulus;
        power /= 2;
    }
    return result;
}

pub fn main() void {
    for (cases) |entry| {
        std.debug.print("{d} {d} {d} {d}\n", .{
            entry.base,
            entry.exponent,
            entry.modulus,
            modpow(entry.base, entry.exponent, entry.modulus),
        });
    }
}
