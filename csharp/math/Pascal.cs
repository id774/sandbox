// Pascal.cs: The first 10 rows of Pascal's triangle
//
// Description:
// Print 10 rows of Pascal's triangle, each row rewritten in place from its right hand end.
//
// Part of the math cross-language exercise set: it reads no arguments or
// standard input, keeps its data fixed in the source, uses integer
// arithmetic only, and its output is the same as that of the same exercise
// in every other language. The exercises are specified in README.md at the
// repository root.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     dotnet run Pascal.cs
//
//     Or use the file as Program.cs in a console project and run it with
//     dotnet run there.
//
// Requirements:
// - .NET 10 SDK or later to run the file directly with dotnet run
// - .NET 8 SDK (C# 12) or later when the file is used as Program.cs in
//   a console project
// - No third-party package is required

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
