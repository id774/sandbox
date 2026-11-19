// std-split.cpp: Split a string on spaces with Boost
//
// Description:
// Split a string of two IP addresses on whitespace with boost::split and print
// each part with BOOST_FOREACH.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Build / Run:
//     c++ -o std-split std-split.cpp
//     ./std-split
//
// Requirements:
// - A C++ compiler such as GCC or Clang
// - The Boost string algorithm and foreach headers
//

#include <boost/algorithm/string.hpp>
#include <string>
#include <list>
#include <iostream>

#include <boost/foreach.hpp>
using namespace std;
int main ()
{
    string str ("192.168.0.1 192.168.0.2");

    list<string> list_string;

    boost::split(list_string, str, boost::is_space());

    BOOST_FOREACH(string s, list_string) {
        cout << s << endl;
    }
    return 0;
}
