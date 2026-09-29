// collatz.zig: Longest Collatz sequence for a start below 1000
//
// Description:
// Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.
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
//     zig build-exe collatz.zig
//     ./collatz
//
// Requirements:
// - Zig 0.16, the release these sources were written against (Zig is
//   pre-1.0, and its standard library changes between releases)
// - No third-party package is required

const std = @import("std");

const limit = 1000;

fn chainLength(start: u64) u32 {
    var value = start;
    var length: u32 = 1;
    while (value != 1) {
        value = if (value % 2 == 0) value / 2 else value * 3 + 1;
        length += 1;
    }
    return length;
}

pub fn main() void {
    var longest: u64 = 1;
    var best: u32 = 1;

    var start: u64 = 1;
    while (start < limit) : (start += 1) {
        const length = chainLength(start);
        if (length > best) {
            longest = start;
            best = length;
        }
    }

    std.debug.print("{d} {d}\n", .{ longest, best });
}
