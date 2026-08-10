// Multiply two fixed 3x3 integer matrices held as arrays of arrays. (written against Zig 0.16)
// Build: zig build-exe matrix.zig

const std = @import("std");

const size = 3;
const Matrix = [size][size]i64;

const left: Matrix = .{ .{ 2, -1, 0 }, .{ 1, 3, 4 }, .{ 0, 5, -2 } };
const right: Matrix = .{ .{ 1, 0, 2 }, .{ -3, 1, 1 }, .{ 4, 2, 0 } };

fn multiply(a: Matrix, b: Matrix) Matrix {
    var product: Matrix = std.mem.zeroes(Matrix);
    for (0..size) |i| {
        for (0..size) |j| {
            for (0..size) |k| {
                product[i][j] += a[i][k] * b[k][j];
            }
        }
    }
    return product;
}

fn determinant(m: Matrix) i64 {
    return m[0][0] * (m[1][1] * m[2][2] - m[1][2] * m[2][1]) -
        m[0][1] * (m[1][0] * m[2][2] - m[1][2] * m[2][0]) +
        m[0][2] * (m[1][0] * m[2][1] - m[1][1] * m[2][0]);
}

pub fn main() void {
    const product = multiply(left, right);

    for (product) |row| {
        for (row, 0..) |value, index| {
            if (index > 0) std.debug.print(" ", .{});
            std.debug.print("{d}", .{value});
        }
        std.debug.print("\n", .{});
    }
    std.debug.print("{d}\n", .{determinant(product)});
}
