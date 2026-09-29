// pascal.zig: The first 10 rows of Pascal's triangle
//
// Description:
// Print 10 rows of Pascal's triangle, each row rewritten in place from its right hand end.
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
//     zig build-exe pascal.zig
//     ./pascal
//
// Requirements:
// - Zig 0.16, the release these sources were written against (Zig is
//   pre-1.0, and its standard library changes between releases)
// - No third-party package is required

const std = @import("std");

const rows = 10;

pub fn main() void {
    var row = [_]u64{0} ** (rows + 1);
    row[0] = 1;

    var length: usize = 1;
    while (length <= rows) : (length += 1) {
        for (row[0..length], 0..) |value, index| {
            if (index > 0) std.debug.print(" ", .{});
            std.debug.print("{d}", .{value});
        }
        std.debug.print("\n", .{});

        var i = length;
        while (i > 0) : (i -= 1) {
            row[i] += row[i - 1];
        }
    }
}
