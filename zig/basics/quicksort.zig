// Sort a fixed array in place with a quicksort over a Lomuto partition.
// Build: zig build-exe quicksort.zig (written against Zig 0.16)

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
