// Sort a fixed array with a quicksort generic over any IComparable element.
// Run: dotnet run Quicksort.cs (file-based app, .NET 10 or later), or as Program.cs in a console project

int[] numbers = [5, 3, 8, 4, 2, 7, 1, 10, 9, 6];
Console.WriteLine(string.Join(" ", Quicksort(numbers)));

static List<T> Quicksort<T>(IReadOnlyList<T> items) where T : IComparable<T>
{
    if (items.Count <= 1)
    {
        return [.. items];
    }

    var pivot = items[0];
    var rest = items.Skip(1).ToList();
    var smaller = rest.Where(x => x.CompareTo(pivot) <= 0).ToList();
    var larger = rest.Where(x => x.CompareTo(pivot) > 0).ToList();
    return [.. Quicksort(smaller), pivot, .. Quicksort(larger)];
}
