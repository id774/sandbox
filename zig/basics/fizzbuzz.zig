// Print FizzBuzz for 1 through 100, formatting the number into a stack buffer.
// Build: zig build-exe fizzbuzz.zig (written against Zig 0.16)

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
