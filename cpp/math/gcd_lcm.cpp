// gcd_lcm.cpp: GCD and LCM of fixed pairs by Euclid's algorithm
//
// Description:
// Print the divisor and multiple of fixed pairs, with Euclid's algorithm written out rather than taken from <numeric>.
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
//     c++ -std=c++20 -o gcd_lcm gcd_lcm.cpp
//     ./gcd_lcm
//
// Requirements:
// - A C++20 compiler run as c++ with -std=c++20, such as GCC 10 or
//   later or Clang 10 or later
// - No third-party package is required

#include <array>
#include <iostream>
#include <utility>

namespace {

long euclid(long first, long second)
{
    while (second != 0) {
        first = std::exchange(second, first % second);
    }
    return first;
}

} // namespace

int main()
{
    constexpr std::array<std::pair<long, long>, 4> pairs{{{1071, 462}, {270, 192}, {17, 5}, {120, 36}}};

    for (const auto& [first, second] : pairs) {
        const long divisor = euclid(first, second);
        std::cout << first << ' ' << second << ' ' << divisor << ' ' << first / divisor * second << '\n';
    }
    return 0;
}
