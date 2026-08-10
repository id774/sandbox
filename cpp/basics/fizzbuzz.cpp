// Print FizzBuzz for 1 through 100, with the label returned as a std::string.
// Build: c++ -std=c++20 -o fizzbuzz fizzbuzz.cpp

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
