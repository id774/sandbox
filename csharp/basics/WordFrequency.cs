// Count the words of a fixed text, most frequent first and alphabetically within a tie.
// Run: dotnet run WordFrequency.cs (file-based app, .NET 10 or later), or as Program.cs in a console project

const string text = "the quick brown fox jumps over the lazy dog the fox barks";

var ranked = text
    .Split(' ', StringSplitOptions.RemoveEmptyEntries)
    .GroupBy(word => word)
    .OrderByDescending(group => group.Count())
    .ThenBy(group => group.Key, StringComparer.Ordinal);

foreach (var group in ranked)
{
    Console.WriteLine($"{group.Key} {group.Count()}");
}
