// word_frequency.zig: Word frequencies of a fixed sentence
//
// Description:
// Count the words of a fixed text, most frequent first and alphabetically within a tie.
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
//     zig build-exe word_frequency.zig
//     ./word_frequency
//
// Requirements:
// - Zig 0.16, the release these sources were written against (Zig is
//   pre-1.0, and its standard library changes between releases)
// - No third-party package is required

const std = @import("std");

const text = "the quick brown fox jumps over the lazy dog the fox barks";

const Entry = struct {
    word: []const u8,
    count: usize,
};

fn byCountThenWord(_: void, a: Entry, b: Entry) bool {
    if (a.count != b.count) return a.count > b.count;
    return std.mem.lessThan(u8, a.word, b.word);
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var counts = std.StringHashMap(usize).init(allocator);
    var words = std.mem.tokenizeScalar(u8, text, ' ');
    while (words.next()) |word| {
        const slot = try counts.getOrPut(word);
        slot.value_ptr.* = if (slot.found_existing) slot.value_ptr.* + 1 else 1;
    }

    var ranked: std.ArrayList(Entry) = .empty;
    var iterator = counts.iterator();
    while (iterator.next()) |pair| {
        try ranked.append(allocator, .{ .word = pair.key_ptr.*, .count = pair.value_ptr.* });
    }
    std.mem.sort(Entry, ranked.items, {}, byCountThenWord);

    for (ranked.items) |entry| {
        std.debug.print("{s} {d}\n", .{ entry.word, entry.count });
    }
}
