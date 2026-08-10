#ifndef _INCLUDE_SORT_H_
#define _INCLUDE_SORT_H_

#include <string>
#include <sstream>

class Sort
{
  private:
    static const int _signature = 0x123f3f7c;

  public:
    Sort(const char* values);
    virtual ~Sort() {}

    bool isLegal() const { return this->_sig == _signature; }

    std::string getValues() const { return this->_values; }
    std::string toString() const;
    std::string greet() const;

  private:
    int _sig;
    std::string _values;
};

#endif
