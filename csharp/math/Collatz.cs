// Collatz.cs: Longest Collatz sequence for a start below 1000
//
// Description:
// Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.
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
// Usage:
//     dotnet run Collatz.cs
//
//     Or use the file as Program.cs in a console project and run it with
//     dotnet run there.
//
// Requirements:
// - .NET 10 SDK or later to run the file directly with dotnet run
// - .NET 8 SDK (C# 12) or later when the file is used as Program.cs in
//   a console project
// - No third-party package is required

const int limit = 1000;

var longest = 1;
var best = 1;

for (var start = 1; start < limit; start++)
{
    var length = ChainLength(start);
    if (length > best)
    {
        longest = start;
        best = length;
    }
}

Console.WriteLine($"{longest} {best}");

static int ChainLength(long value)
{
    var count = 1;
    while (value != 1)
    {
        value = value % 2 == 0 ? value / 2 : value * 3 + 1;
        count++;
    }

    return count;
}
