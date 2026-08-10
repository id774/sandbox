// Print the primes below 100, sieved over a bool array and gathered with LINQ.
// Run: dotnet run Sieve.cs (file-based app, .NET 10 or later), or as Program.cs in a console project

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
