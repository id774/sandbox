// Matrix.cs: Product and determinant of two fixed 3x3 integer matrices
//
// Description:
// Multiply two fixed 3x3 integer matrices held as rectangular arrays.
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
//     dotnet run Matrix.cs
//
//     Or use the file as Program.cs in a console project and run it with
//     dotnet run there.
//
// Requirements:
// - .NET 10 SDK or later to run the file directly with dotnet run
// - .NET 8 SDK (C# 12) or later when the file is used as Program.cs in
//   a console project
// - No third-party package is required

var left = new[,] { { 2, -1, 0 }, { 1, 3, 4 }, { 0, 5, -2 } };
var right = new[,] { { 1, 0, 2 }, { -3, 1, 1 }, { 4, 2, 0 } };

var product = Multiply(left, right);

for (var i = 0; i < product.GetLength(0); i++)
{
    var row = new int[product.GetLength(1)];
    for (var j = 0; j < row.Length; j++)
    {
        row[j] = product[i, j];
    }

    Console.WriteLine(string.Join(" ", row));
}

Console.WriteLine(Determinant(product));

static int[,] Multiply(int[,] a, int[,] b)
{
    var size = a.GetLength(0);
    var product = new int[size, size];

    for (var i = 0; i < size; i++)
    {
        for (var j = 0; j < size; j++)
        {
            for (var k = 0; k < size; k++)
            {
                product[i, j] += a[i, k] * b[k, j];
            }
        }
    }

    return product;
}

static int Determinant(int[,] m) =>
    m[0, 0] * (m[1, 1] * m[2, 2] - m[1, 2] * m[2, 1])
    - m[0, 1] * (m[1, 0] * m[2, 2] - m[1, 2] * m[2, 0])
    + m[0, 2] * (m[1, 0] * m[2, 1] - m[1, 1] * m[2, 0]);
