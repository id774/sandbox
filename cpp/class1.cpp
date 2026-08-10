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
