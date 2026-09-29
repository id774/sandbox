// sieve.cpp: Primes below 100 by the sieve of Eratosthenes
//
// Description:
// Print the primes below 100, sieved over a vector<bool> and gathered into a vector of indices.
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
//     c++ -std=c++20 -o sieve sieve.cpp
//     ./sieve
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
    constexpr std::size_t limit = 100;

    std::vector<bool> is_prime(limit, true);
    is_prime[0] = is_prime[1] = false;

    for (std::size_t n = 2; n * n < limit; ++n) {
        if (!is_prime[n]) {
            continue;
        }
        for (std::size_t multiple = n * n; multiple < limit; multiple += n) {
            is_prime[multiple] = false;
        }
    }

    bool first = true;
    for (std::size_t n = 0; n < limit; ++n) {
        if (is_prime[n]) {
            std::cout << (first ? "" : " ") << n;
            first = false;
        }
    }
    std::cout << '\n';
    return 0;
}
