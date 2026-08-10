// Print FizzBuzz for 1 through 100, choosing the label with a switch expression on a tuple.
// Run: dotnet run FizzBuzz.cs (file-based app, .NET 10 or later), or as Program.cs in a console project

for (var n = 1; n <= 100; n++)
{
    Console.WriteLine((n % 3, n % 5) switch
    {
        (0, 0) => "FizzBuzz",
        (0, _) => "Fizz",
        (_, 0) => "Buzz",
        _ => n.ToString(),
    });
}
