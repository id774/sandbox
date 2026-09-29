// gcd_lcm.zig: GCD and LCM of fixed pairs by Euclid's algorithm
//
// Description:
// Print the divisor and multiple of fixed pairs, with Euclid's algorithm run on a mem.swap free loop.
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
//     zig build-exe gcd_lcm.zig
//     ./gcd_lcm
//
// Requirements:
// - Zig 0.16, the release these sources were written against (Zig is
//   pre-1.0, and its standard library changes between releases)
// - No third-party package is required

const std = @import("std");

const Pair = struct { first: u64, second: u64 };

const pairs = [_]Pair{
    .{ .first = 1071, .second = 462 },
    .{ .first = 270, .second = 192 },
    .{ .first = 17, .second = 5 },
    .{ .first = 120, .second = 36 },
};

fn euclid(first: u64, second: u64) u64 {
    var a = first;
    var b = second;
    while (b != 0) {
        const remainder = a % b;
        a = b;
        b = remainder;
    }
    return a;
}

pub fn main() void {
    for (pairs) |pair| {
        const divisor = euclid(pair.first, pair.second);
        std.debug.print("{d} {d} {d} {d}\n", .{
            pair.first,
            pair.second,
            divisor,
            pair.first / divisor * pair.second,
        });
    }
}
