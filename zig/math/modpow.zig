// Print modular powers of fixed triples, each squared and halved by repeated squaring. (written against Zig 0.16)
// Build: zig build-exe modpow.zig

const std = @import("std");

const Case = struct { base: u64, exponent: u64, modulus: u64 };

const cases = [_]Case{
    .{ .base = 2, .exponent = 1000, .modulus = 1000003 },
    .{ .base = 3, .exponent = 200, .modulus = 50 },
    .{ .base = 5, .exponent = 117, .modulus = 19 },
    .{ .base = 10, .exponent = 18, .modulus = 9999991 },
};

fn modpow(base: u64, exponent: u64, modulus: u64) u64 {
    var factor = base % modulus;
    var power = exponent;
    var result: u64 = 1;

    while (power > 0) {
        if (power % 2 == 1) result = result * factor % modulus;
        factor = factor * factor % modulus;
        power /= 2;
    }
    return result;
}

pub fn main() void {
    for (cases) |entry| {
        std.debug.print("{d} {d} {d} {d}\n", .{
            entry.base,
            entry.exponent,
            entry.modulus,
            modpow(entry.base, entry.exponent, entry.modulus),
        });
    }
}
