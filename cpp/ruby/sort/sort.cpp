#include "sort.h"
#include <algorithm>
#include <functional>
#include <array>
#include <iostream>

using namespace std;

Sort::Sort(const char* values) {
    this->_sig  = _signature;
    this->_values = values;
}

std::string Sort::greet() const {
    std::ostringstream ret;

    ret << "My name is "
        << this->_values
        << ".";
    ret << '\n';

    std::array<int, 10> s = {5, 7, 4, 2, 8, 6, 1, 9, 0, 3};

    // sort using the default operator<
    std::sort(s.begin(), s.end());
    for (int a : s) {
        ret << a << " ";
    }
    ret << '\n';

    // sort using a standard library compare function object
    std::sort(s.begin(), s.end(), std::greater<int>());
    for (int a : s) {
        ret << a << " ";
    }
    ret << '\n';

    // sort using a custom function object
    struct {
        bool operator()(int a, int b)
        {
            return a < b;
        }
    } customLess;
    std::sort(s.begin(), s.end(), customLess);
    for (int a : s) {
        ret << a << " ";
    }
    ret << '\n';

    // sort using a lambda expression
    std::sort(s.begin(), s.end(), [](int a, int b) {
        return b < a;
    });
    for (int a : s) {
        ret << a << " ";
    }
    ret << '\n';

    return ret.str();
}
