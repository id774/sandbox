// human.hxx: Human class declaration
//
// Description:
// Declare the Human class used by the human Ruby extension.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//

#ifndef _INCLUDE_HUMAN_H_
#define _INCLUDE_HUMAN_H_

#include <string>
#include <sstream>

class Human
{
  private:
    static const int _signature = 0x123f3f7c;

  public:
    Human(const char* name, int age);
    virtual ~Human() {}

    bool isLegal() const { return this->_sig == _signature; }

    std::string getName() const { return this->_name; }
    int getAge() const { return this->_age; }
    std::string toString() const;
    std::string greet() const;

  private:
    int _sig;
    std::string _name;
    int _age;
};

#endif // _INCLUDE_HUMAN_H_
