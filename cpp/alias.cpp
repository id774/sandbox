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
