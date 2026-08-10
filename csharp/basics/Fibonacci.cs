// Print the first 20 Fibonacci numbers from an iterator method built on yield return.
// Run: dotnet run Fibonacci.cs (file-based app, .NET 10 or later), or as Program.cs in a console project

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
