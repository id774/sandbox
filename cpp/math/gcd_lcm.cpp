// Print the divisor and multiple of fixed pairs, with Euclid's algorithm written out rather than taken from <numeric>.
// Build: c++ -std=c++20 -o gcd_lcm gcd_lcm.cpp

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
