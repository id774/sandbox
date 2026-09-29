// fizzbuzz.cpp: FizzBuzz for 1 through 100
//
// Description:
// Print FizzBuzz for 1 through 100, with the label returned as a std::string.
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
//     c++ -std=c++20 -o fizzbuzz fizzbuzz.cpp
//     ./fizzbuzz
//
// Requirements:
// - A C++20 compiler run as c++ with -std=c++20, such as GCC 10 or
//   later or Clang 10 or later
// - No third-party package is required

#include <iostream>
#include <string>

std::string label(int n)
{
    if (n % 15 == 0) {
        return "FizzBuzz";
    }
    if (n % 3 == 0) {
        return "Fizz";
    }
    if (n % 5 == 0) {
        return "Buzz";
    }
    return std::to_string(n);
}

int main()
{
    for (int n = 1; n <= 100; ++n) {
        std::cout << label(n) << '\n';
    }
}
