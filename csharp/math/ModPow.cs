// Print modular powers of fixed triples, each squared and shifted down rather than left to BigInteger.
// Run: dotnet run ModPow.cs (file-based app, .NET 10 or later), or as Program.cs in a console project

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
