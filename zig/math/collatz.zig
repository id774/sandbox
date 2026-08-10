// Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum. (written against Zig 0.16)
// Build: zig build-exe collatz.zig

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
