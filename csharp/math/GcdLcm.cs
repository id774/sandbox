// Print the divisor and multiple of fixed pairs, with Euclid's algorithm run on a tuple swap.
// Run: dotnet run GcdLcm.cs (file-based app, .NET 10 or later), or as Program.cs in a console project

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
