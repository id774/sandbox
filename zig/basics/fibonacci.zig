// fibonacci.zig: The first 20 Fibonacci numbers
//
// Description:
// Print the first 20 Fibonacci numbers, carried in two mutable locals.
//
// Part of the basics cross-language exercise set: the input is fixed in the
// source, and the output is the same as that of the same exercise in every
// other language. The exercises are specified in README.md at the
// repository root.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Build / Run:
//     zig build-exe fibonacci.zig
//     ./fibonacci
//
// Requirements:
// - Zig 0.16, the release these sources were written against (Zig is
//   pre-1.0, and its standard library changes between releases)
// - No third-party package is required

const std = @import("std");

pub fn main() void {
    var current: u64 = 0;
    var next: u64 = 1;
    var i: usize = 0;
    while (i < 20) : (i += 1) {
        if (i > 0) std.debug.print(" ", .{});
        std.debug.print("{d}", .{current});
        const following = current + next;
        current = next;
        next = following;
    }
    std.debug.print("\n", .{});
}
