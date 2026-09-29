// ModPow.cs: Modular exponentiation of fixed triples by repeated squaring
//
// Description:
// Print modular powers of fixed triples, each squared and shifted down rather than left to BigInteger.
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
//     dotnet run ModPow.cs
//
//     Or use the file as Program.cs in a console project and run it with
//     dotnet run there.
//
// Requirements:
// - .NET 10 SDK or later to run the file directly with dotnet run
// - .NET 8 SDK (C# 12) or later when the file is used as Program.cs in
//   a console project
// - No third-party package is required

var cases = new (long Value, long Exponent, long Modulus)[]
{
    (2, 1000, 1000003),
    (3, 200, 50),
    (5, 117, 19),
    (10, 18, 9999991),
};

foreach (var (value, exponent, modulus) in cases)
{
    Console.WriteLine($"{value} {exponent} {modulus} {ModularPower(value, exponent, modulus)}");
}

static long ModularPower(long factor, long power, long modulus)
{
    long result = 1;
    factor %= modulus;

    while (power > 0)
    {
        if ((power & 1) == 1)
        {
            result = result * factor % modulus;
        }

        factor = factor * factor % modulus;
        power >>= 1;
    }

    return result;
}
