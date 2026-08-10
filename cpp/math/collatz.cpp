// Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.
// Build: c++ -std=c++20 -o collatz collatz.cpp

#include <iostream>

namespace {

int chain_length(long start)
{
    int length = 1;

    while (start != 1) {
        start = start % 2 == 0 ? start / 2 : start * 3 + 1;
        ++length;
    }
    return length;
}

} // namespace

int main()
{
    constexpr int limit = 1000;

    int longest = 1;
    int best = 1;

    for (int start = 1; start < limit; ++start) {
        const int length = chain_length(start);
        if (length > best) {
            longest = start;
            best = length;
        }
    }
    std::cout << longest << ' ' << best << '\n';
    return 0;
}
