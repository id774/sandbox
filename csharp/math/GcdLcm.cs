// GcdLcm.cs: GCD and LCM of fixed pairs by Euclid's algorithm
//
// Description:
// Print the divisor and multiple of fixed pairs, with Euclid's algorithm run on a tuple swap.
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
//     dotnet run GcdLcm.cs
//
//     Or use the file as Program.cs in a console project and run it with
//     dotnet run there.
//
// Requirements:
// - .NET 10 SDK or later to run the file directly with dotnet run
// - .NET 8 SDK (C# 12) or later when the file is used as Program.cs in
//   a console project
// - No third-party package is required

var pairs = new (long First, long Second)[] { (1071, 462), (270, 192), (17, 5), (120, 36) };

foreach (var (first, second) in pairs)
{
    var divisor = Euclid(first, second);
    Console.WriteLine($"{first} {second} {divisor} {first / divisor * second}");
}

static long Euclid(long a, long b)
{
    while (b != 0)
    {
        (a, b) = (b, a % b);
    }

    return a;
}
