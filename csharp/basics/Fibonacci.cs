// Fibonacci.cs: The first 20 Fibonacci numbers
//
// Description:
// Print the first 20 Fibonacci numbers from an iterator method built on yield return.
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
// Usage:
//     dotnet run Fibonacci.cs
//
//     Or use the file as Program.cs in a console project and run it with
//     dotnet run there.
//
// Requirements:
// - .NET 10 SDK or later to run the file directly with dotnet run
// - .NET 8 SDK (C# 12) or later when the file is used as Program.cs in
//   a console project
// - No third-party package is required

Console.WriteLine(string.Join(" ", Fibonacci().Take(20)));

static IEnumerable<long> Fibonacci()
{
    (long current, long next) = (0L, 1L);
    while (true)
    {
        yield return current;
        (current, next) = (next, current + next);
    }
}
