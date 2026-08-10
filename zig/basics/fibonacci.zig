// Print the first 20 Fibonacci numbers, carried in two mutable locals.
// Build: zig build-exe fibonacci.zig (written against Zig 0.16)

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
