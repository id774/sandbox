// Print 10 rows of Pascal's triangle, each row grown by inserting and accumulating from the back.
// Build: c++ -std=c++20 -o pascal pascal.cpp

#include <cstddef>
#include <iostream>
#include <vector>

int main()
{
    constexpr int rows = 10;

    std::vector<int> row{1};

    for (int length = 1; length <= rows; ++length) {
        for (std::size_t i = 0; i < row.size(); ++i) {
            std::cout << (i > 0 ? " " : "") << row[i];
        }
        std::cout << '\n';

        row.push_back(0);
        for (std::size_t i = row.size() - 1; i > 0; --i) {
            row[i] += row[i - 1];
        }
    }
    return 0;
}
