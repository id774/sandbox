// quicksort.zig: Quicksort of a fixed integer sequence
//
// Description:
// Sort a fixed array in place with a quicksort over a Lomuto partition.
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
//     zig build-exe quicksort.zig
//     ./quicksort
//
// Requirements:
// - Zig 0.16, the release these sources were written against (Zig is
//   pre-1.0, and its standard library changes between releases)
// - No third-party package is required

const std = @import("std");

fn quicksort(items: []i32) void {
    if (items.len <= 1) return;

    const pivot = items[items.len - 1];
    var boundary: usize = 0;
    var i: usize = 0;
    while (i < items.len - 1) : (i += 1) {
        if (items[i] <= pivot) {
            std.mem.swap(i32, &items[i], &items[boundary]);
            boundary += 1;
        }
    }
    std.mem.swap(i32, &items[items.len - 1], &items[boundary]);

    quicksort(items[0..boundary]);
    quicksort(items[boundary + 1 ..]);
}

pub fn main() void {
    var numbers = [_]i32{ 5, 3, 8, 4, 2, 7, 1, 10, 9, 6 };
    quicksort(&numbers);
    for (numbers, 0..) |value, index| {
        if (index > 0) std.debug.print(" ", .{});
        std.debug.print("{d}", .{value});
    }
    std.debug.print("\n", .{});
}
