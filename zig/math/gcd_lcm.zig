// Print the divisor and multiple of fixed pairs, with Euclid's algorithm run on a mem.swap free loop. (written against Zig 0.16)
// Build: zig build-exe gcd_lcm.zig

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
