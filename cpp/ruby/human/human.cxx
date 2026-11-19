// human.cxx: Human class implementation
//
// Description:
// Implement the Human class, which formats its name and age with toString and
// greet. humanwrap.cxx exposes it to Ruby.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//

#include "human.hxx"

Human::Human(const char* name, int age) {
  this->_sig  = _signature;
  this->_name = name;
  this->_age  = age;
}

std::string Human::toString() const {
  std::ostringstream ret;
  ret << "Human [name="
      << this->_name
      << ", age="
      << this->_age
      << "]";
  return ret.str();
}

std::string Human::greet() const {
  std::ostringstream ret;
  ret << "My name is "
      << this->_name
      << ". I'm "
      << this->_age
      << " years old.";
  return ret.str();
}
