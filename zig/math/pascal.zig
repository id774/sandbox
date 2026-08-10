// Print 10 rows of Pascal's triangle, each row rewritten in place from its right hand end. (written against Zig 0.16)
// Build: zig build-exe pascal.zig

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
