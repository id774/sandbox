// alias.cpp: Modify a variable through a reference
//
// Description:
// Assign 100 to an int through a reference alias and print both names.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Build / Run:
//     c++ -o alias alias.cpp
//     ./alias
//
// Requirements:
// - A C++ compiler such as GCC or Clang
//

#include <iostream>
using namespace std;

int main() {
    int i;
    int &alias = i;
    alias = 100;
    cout << i << endl;
    cout << alias << endl;
    return 0;
}
