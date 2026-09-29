// pascal.cpp: The first 10 rows of Pascal's triangle
//
// Description:
// Print 10 rows of Pascal's triangle, each row grown by inserting and accumulating from the back.
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
// Build / Run:
//     c++ -std=c++20 -o pascal pascal.cpp
//     ./pascal
//
// Requirements:
// - A C++20 compiler run as c++ with -std=c++20, such as GCC 10 or
//   later or Clang 10 or later
// - No third-party package is required

#include <cstddef>
#include <iostream>
#include <vector>

int main()
{
    constexpr int rows = 10;

    std::vector<int> row{1};

    for (int length = 1; length <= rows; ++length) {
        for (std::size_t i = 0; i < row.size(); ++i) {
            std::cout << (i > 0 ? " " : "") << row[i];
        }
        std::cout << '\n';

        row.push_back(0);
        for (std::size_t i = row.size() - 1; i > 0; --i) {
            row[i] += row[i - 1];
        }
    }
    return 0;
}
