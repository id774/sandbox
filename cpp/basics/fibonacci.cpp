// Print the first 20 Fibonacci numbers, collected into a vector.
// Build: c++ -std=c++20 -o fibonacci fibonacci.cpp

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
