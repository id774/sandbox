// hello.cpp: Greeting function with a default argument
//
// Description:
// Print greetings through a function whose second parameter defaults to
// "world".
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Build / Run:
//     c++ -o hello hello.cpp
//     ./hello
//
// Requirements:
// - A C++ compiler such as GCC or Clang
//

#include <iostream>

using namespace std;

void hello(const char *name, const char *name2 = "world") {
    cout << "Hello, " << name << " " << name2 << endl;
}

int main(){
    hello("cpp");
    hello("world");
    hello("world","world");
    return 0;
}

