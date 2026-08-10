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
