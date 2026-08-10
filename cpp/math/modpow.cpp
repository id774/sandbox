// Print modular powers of fixed triples, each squared and halved by repeated squaring.
// Build: c++ -std=c++20 -o modpow modpow.cpp

#include <array>
#include <cstdint>
#include <iostream>

namespace {

struct Case {
    std::int64_t base;
    std::int64_t exponent;
    std::int64_t modulus;
};

std::int64_t modpow(std::int64_t base, std::int64_t exponent, std::int64_t modulus)
{
    std::int64_t result = 1;

    base %= modulus;
    while (exponent > 0) {
        if (exponent % 2 == 1) {
            result = result * base % modulus;
        }
        base = base * base % modulus;
        exponent /= 2;
    }
    return result;
}

} // namespace

int main()
{
    constexpr std::array<Case, 4> cases{{{2, 1000, 1000003}, {3, 200, 50}, {5, 117, 19}, {10, 18, 9999991}}};

    for (const auto& [base, exponent, modulus] : cases) {
        std::cout << base << ' ' << exponent << ' ' << modulus << ' '
                  << modpow(base, exponent, modulus) << '\n';
    }
    return 0;
}
