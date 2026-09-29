// fibonacci.cpp: The first 20 Fibonacci numbers
//
// Description:
// Print the first 20 Fibonacci numbers, collected into a vector.
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
// Build / Run:
//     c++ -std=c++20 -o fibonacci fibonacci.cpp
//     ./fibonacci
//
// Requirements:
// - A C++20 compiler run as c++ with -std=c++20, such as GCC 10 or
//   later or Clang 10 or later
// - No third-party package is required

#include <cstddef>
#include <cstdint>
#include <iostream>
#include <vector>

std::vector<std::uint64_t> fibonacci(std::size_t count)
{
    std::vector<std::uint64_t> values;
    values.reserve(count);

    std::uint64_t current = 0;
    std::uint64_t next = 1;
    for (std::size_t i = 0; i < count; ++i) {
        values.push_back(current);
        const std::uint64_t following = current + next;
        current = next;
        next = following;
    }
    return values;
}

int main()
{
    const auto values = fibonacci(20);
    for (std::size_t i = 0; i < values.size(); ++i) {
        std::cout << (i > 0 ? " " : "") << values[i];
    }
    std::cout << '\n';
}
