// Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.
// Run: dotnet run Collatz.cs (file-based app, .NET 10 or later), or as Program.cs in a console project

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
