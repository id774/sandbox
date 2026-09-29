// Sieve.cs: Primes below 100 by the sieve of Eratosthenes
//
// Description:
// Print the primes below 100, sieved over a bool array and gathered with LINQ.
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
//     dotnet run Sieve.cs
//
//     Or use the file as Program.cs in a console project and run it with
//     dotnet run there.
//
// Requirements:
// - .NET 10 SDK or later to run the file directly with dotnet run
// - .NET 8 SDK (C# 12) or later when the file is used as Program.cs in
//   a console project
// - No third-party package is required

const int limit = 100;

var isPrime = new bool[limit];
for (var n = 2; n < limit; n++)
{
    isPrime[n] = true;
}

for (var n = 2; n * n < limit; n++)
{
    if (!isPrime[n])
    {
        continue;
    }

    for (var multiple = n * n; multiple < limit; multiple += n)
    {
        isPrime[multiple] = false;
    }
}

Console.WriteLine(string.Join(" ", Enumerable.Range(0, limit).Where(n => isPrime[n])));
