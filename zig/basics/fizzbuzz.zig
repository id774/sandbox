// fizzbuzz.zig: FizzBuzz for 1 through 100
//
// Description:
// Print FizzBuzz for 1 through 100, formatting the number into a stack buffer.
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
//     zig build-exe fizzbuzz.zig
//     ./fizzbuzz
//
// Requirements:
// - Zig 0.16, the release these sources were written against (Zig is
//   pre-1.0, and its standard library changes between releases)
// - No third-party package is required

const std = @import("std");

fn fizzBuzzLabel(n: u32, buffer: []u8) []const u8 {
    if (n % 15 == 0) return "FizzBuzz";
    if (n % 3 == 0) return "Fizz";
    if (n % 5 == 0) return "Buzz";
    return std.fmt.bufPrint(buffer, "{d}", .{n}) catch unreachable;
}

pub fn main() void {
    var buffer: [16]u8 = undefined;
    var n: u32 = 1;
    while (n <= 100) : (n += 1) {
        std.debug.print("{s}\n", .{fizzBuzzLabel(n, &buffer)});
    }
}
