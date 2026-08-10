// Multiply two fixed 3x3 integer matrices held as std::array of std::array.
// Build: c++ -std=c++20 -o matrix matrix.cpp

#include <array>
#include <cstddef>
#include <iostream>

namespace {

constexpr std::size_t size = 3;

using Matrix = std::array<std::array<int, size>, size>;

Matrix multiply(const Matrix& left, const Matrix& right)
{
    Matrix product{};

    for (std::size_t i = 0; i < size; ++i) {
        for (std::size_t j = 0; j < size; ++j) {
            for (std::size_t k = 0; k < size; ++k) {
                product[i][j] += left[i][k] * right[k][j];
            }
        }
    }
    return product;
}

int determinant(const Matrix& m)
{
    return m[0][0] * (m[1][1] * m[2][2] - m[1][2] * m[2][1])
         - m[0][1] * (m[1][0] * m[2][2] - m[1][2] * m[2][0])
         + m[0][2] * (m[1][0] * m[2][1] - m[1][1] * m[2][0]);
}

} // namespace

int main()
{
    constexpr Matrix left{{{2, -1, 0}, {1, 3, 4}, {0, 5, -2}}};
    constexpr Matrix right{{{1, 0, 2}, {-3, 1, 1}, {4, 2, 0}}};

    const Matrix product = multiply(left, right);

    for (const auto& row : product) {
        for (std::size_t j = 0; j < size; ++j) {
            std::cout << (j > 0 ? " " : "") << row[j];
        }
        std::cout << '\n';
    }
    std::cout << determinant(product) << '\n';
    return 0;
}
