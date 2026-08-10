// Print 10 rows of Pascal's triangle, each row rewritten in place from its right hand end.
// Run: dotnet run Pascal.cs (file-based app, .NET 10 or later), or as Program.cs in a console project

const int rows = 10;

var row = new long[rows + 1];
row[0] = 1;

for (var length = 1; length <= rows; length++)
{
    Console.WriteLine(string.Join(" ", row.Take(length)));

    for (var i = length; i > 0; i--)
    {
        row[i] += row[i - 1];
    }
}
