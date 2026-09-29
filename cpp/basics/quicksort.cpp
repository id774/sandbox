// quicksort.cpp: Quicksort of a fixed integer sequence
//
// Description:
// Sort a fixed vector with a quicksort templated on the element type.
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
//     c++ -std=c++20 -o quicksort quicksort.cpp
//     ./quicksort
//
// Requirements:
// - A C++20 compiler run as c++ with -std=c++20, such as GCC 10 or
//   later or Clang 10 or later
// - No third-party package is required

#include <cstddef>
#include <iostream>
#include <vector>

template <typename T>
std::vector<T> quicksort(const std::vector<T>& items)
{
    if (items.size() <= 1) {
        return std::vector<T>(items.begin(), items.end());
    }

    const T pivot = items.front();
    std::vector<T> smaller;
    std::vector<T> larger;
    for (std::size_t i = 1; i < items.size(); ++i) {
        (items[i] <= pivot ? smaller : larger).push_back(items[i]);
    }

    std::vector<T> sorted = quicksort(smaller);
    sorted.push_back(pivot);
    const std::vector<T> tail = quicksort(larger);
    sorted.insert(sorted.end(), tail.begin(), tail.end());
    return sorted;
}

int main()
{
    const std::vector<int> numbers { 5, 3, 8, 4, 2, 7, 1, 10, 9, 6 };
    const auto sorted = quicksort(numbers);
    for (std::size_t i = 0; i < sorted.size(); ++i) {
        std::cout << (i > 0 ? " " : "") << sorted[i];
    }
    std::cout << '\n';
}
