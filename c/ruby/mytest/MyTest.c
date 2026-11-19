/*
 * MyTest.c: Ruby C extension module defining MyTest#test1
 *
 * Description:
 * Ruby C extension that defines the MyTest module and its test1 method, which
 * returns 10. extconf.rb generates the Makefile that builds it, and test.rb
 * loads it.
 *
 * Author: id774 (More info: https://id774.net)
 * Source Code: https://github.com/id774/sandbox
 * License: The GPL version 3, or LGPL version 3 (Dual License).
 * Contact: idnanashi@gmail.com
 */

// Include the Ruby headers and goodies
#include "ruby.h"

// Defining a space for information and references about the module to be stored internally
VALUE MyTest = Qnil;

// Prototype for the initialization method - Ruby calls this, not you
void Init_mytest();

// Prototype for our method 'test1' - methods are prefixed by 'method_' here
VALUE method_test1(VALUE self);

// The initialization method for this module
void Init_mytest() {
  MyTest = rb_define_module("MyTest");
  rb_define_method(MyTest, "test1", method_test1, 0);
}

// Our 'test1' method.. it simply returns a value of '10' for now.
VALUE method_test1(VALUE self) {
  int x = 10;
  return INT2NUM(x);
}
