
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
