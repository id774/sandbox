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

