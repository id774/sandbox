// Print the primes below 100, sieved over a vector<bool> and gathered into a vector of indices.
// Build: c++ -std=c++20 -o sieve sieve.cpp

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
