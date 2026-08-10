// Print the primes below 100, sieved over a fixed array of flags. (written against Zig 0.16)
// Build: zig build-exe sieve.zig

const std = @import("std");

const limit = 100;

pub fn main() void {
    var is_prime = [_]bool{true} ** limit;
    is_prime[0] = false;
    is_prime[1] = false;

    var n: usize = 2;
    while (n * n < limit) : (n += 1) {
        if (!is_prime[n]) continue;
        var multiple = n * n;
        while (multiple < limit) : (multiple += n) {
            is_prime[multiple] = false;
        }
    }

    var first = true;
    for (is_prime, 0..) |prime, value| {
        if (!prime) continue;
        if (!first) std.debug.print(" ", .{});
        std.debug.print("{d}", .{value});
        first = false;
    }
    std.debug.print("\n", .{});
}
