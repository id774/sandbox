// http://pokotsun.mydns.jp/?p=605
#include <iostream>
#include <cstdlib>
 
using namespace std;
static const int Max = 10;
 
// 配列の要素を交換
void swap( int a[], int i, int j ) {
    int tmp = a[i];
    a[i] = a[j];
    a[j] = tmp;
}
 
// 降順の半順序木(ヒープ)を構成
void DownHeap( int a[], int leaf, int root ) {
    int i = root * 2;
    while ( i <= leaf ) {
        if ( i < leaf && a[i+1 -(1)] > a[i -(1)] ) {// a[i] と a[i + 1] の大きい方と
            i++;
        }
        if ( a[root -(1)] >= a[i -(1)] ) {          // a[root] と比較
            break;                                  // 子の方が大きければ
        }
        swap( a, root -(1), i -(1) );               // 交換
        root = i;                                   // 更にその子についても調べる
        i = root * 2;
    }
 
    cout << " c- ";
    for ( int i=0; i<10; i++ ) {
        cout << a[ i ] << ",";
    }
    cout << endl;
}
 
// ヒープソートを行う
void heapSort( int a[], int n ) {
    // ２分岐の特性を使って末尾要素とその親を確定
    int leaf = n;                               // 初期値は末尾の要素
    int root = n/2;                             // 初期値はその親
     
    while ( root > 0 ) {                        // 半順序木を構成
        DownHeap( a, leaf, root );
        root--;
    }
     
    cout << "  - ";
    for ( int i=0; i<n; i++ ) {
        cout << a[ i ] << ",";
    }
    cout << endl;
     
    while ( leaf > 0 ) {
        swap( a, 1 -(1), leaf -(1) );           // 半順序木の根と末尾の要素を交換
        leaf--;                                 // 末尾の要素を半順序木から外す
        DownHeap( a, leaf, 1 );                 // 半順序木を再構成する
    }
}
 
int main() {
    srand( 4 );
     
    cout << "+ 初期状態" << endl;
    cout << "  - ";
    int* a = new int[ Max ];
    for ( int i=0; i<Max; i++ ) {
        a[ i ] = rand() % 200;
        cout << a[ i ] << ",";
    }
    cout << endl;
    cout << endl;
     
    // 処理
    cout << "+ 処理開始" << endl;
    heapSort( a, Max );
    cout << endl;
 
    // 結果
    cout << "+ 処理結果" << endl;
    cout << "  - ";
    for ( int i=0; i<Max; i++ ) {
        cout << a[ i ] << ",";
    }
    cout << endl;
 
    delete[] a;
     
    while ( 1 ) { ; }
    return 0;
}
