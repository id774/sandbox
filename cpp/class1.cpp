// class1.cpp: Class with a constructor, destructor, and accessors
//
// Description:
// Construct two Foo objects, read and write a private member through
// accessors, and print messages from the constructor and destructor.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Build / Run:
//     c++ -o class1 class1.cpp
//     ./class1
//
// Requirements:
// - A C++ compiler such as GCC or Clang
//

#include <iostream>
using namespace std;

class Foo {
    int hage;
public:
    int hoge;
    int read_hage(){
        return hage;
    }
    int write_hage(int new_hage){
        hage = new_hage;
        return hage;
    }
    Foo(int new_hage) {
        write_hage(new_hage);
        cout << "initialized new Foo. hoge = " << hage << endl;
    }
    ~Foo() {
        cout << "Foo ( hoge = " << hage << " ) is destroyed." << endl;
    }
};

int main(void) {
    Foo bar(150), bor(200);
    bar.hoge = 100;
    bar.write_hage(bar.hoge);
    cout << bar.read_hage() << endl;
    cout << bar.hoge << endl;
    return 0;
}
