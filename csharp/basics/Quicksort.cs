// Quicksort.cs: Quicksort of a fixed integer sequence
//
// Description:
// Sort a fixed array with a quicksort generic over any IComparable element.
//
// Part of the basics cross-language exercise set: the input is fixed in the
// source, and the output is the same as that of the same exercise in every
// other language. The exercises are specified in README.md at the
// repository root.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     dotnet run Quicksort.cs
//
//     Or use the file as Program.cs in a console project and run it with
//     dotnet run there.
//
// Requirements:
// - .NET 10 SDK or later to run the file directly with dotnet run
// - .NET 8 SDK (C# 12) or later when the file is used as Program.cs in
//   a console project
// - No third-party package is required

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
