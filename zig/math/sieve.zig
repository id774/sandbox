// sieve.zig: Primes below 100 by the sieve of Eratosthenes
//
// Description:
// Print the primes below 100, sieved over a fixed array of flags.
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
//     zig build-exe sieve.zig
//     ./sieve
//
// Requirements:
// - Zig 0.16, the release these sources were written against (Zig is
//   pre-1.0, and its standard library changes between releases)
// - No third-party package is required

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
