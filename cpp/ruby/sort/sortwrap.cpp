// sortwrap.cpp: Ruby wrapper for the Sort class
//
// Description:
// Expose the Sort class to Ruby with an initializer taking a string, and the
// inspect, to_s, greet, and values methods.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//

#include <new>
#include "ruby.h"
#include "sort.h"

extern "C" void Init_sort();
static void   wrap_Sort_free(Sort* p);
static VALUE  wrap_Sort_alloc(VALUE klass);
static VALUE  wrap_Sort_init(VALUE self, VALUE _values);
static VALUE  wrap_Sort_toString(VALUE self);
static VALUE  wrap_Sort_greet(VALUE self);
static VALUE  wrap_Sort_getValues(VALUE self);
static Sort* getSort(VALUE self);

static Sort* getSort(VALUE self) {
  Sort* p;
  Data_Get_Struct(self, Sort, p);
  return p;
}

static void wrap_Sort_free(Sort* p) {
  if (p->isLegal()) p->~Sort();
  ruby_xfree(p);
}

static VALUE wrap_Sort_alloc(VALUE klass) {
  return Data_Wrap_Struct(klass, NULL, wrap_Sort_free, ruby_xmalloc(sizeof(Sort)));
}

static VALUE wrap_Sort_init(VALUE self, VALUE _values) {
  const char* values = StringValuePtr(_values);

  Sort* p = getSort(self);
  new (p) Sort(values);

  return Qnil;
}

static VALUE wrap_Sort_toString(VALUE self) {
  return rb_str_new2(getSort(self)->toString().c_str());
}

static VALUE wrap_Sort_greet(VALUE self) {
  return rb_str_new2(getSort(self)->greet().c_str());
}

static VALUE wrap_Sort_getValues(VALUE self) {
  return rb_str_new2(getSort(self)->getValues().c_str());
}

void Init_sort() {
  VALUE c = rb_define_class("Sort", rb_cObject);

  rb_define_alloc_func(c, wrap_Sort_alloc);
  rb_define_private_method(c, "initialize", RUBY_METHOD_FUNC(wrap_Sort_init), 1);
  rb_define_method(c, "inspect", RUBY_METHOD_FUNC(wrap_Sort_toString), 0);
  rb_define_method(c, "to_s", RUBY_METHOD_FUNC(wrap_Sort_toString), 0);
  rb_define_method(c, "greet", RUBY_METHOD_FUNC(wrap_Sort_greet), 0);
  rb_define_method(c, "values", RUBY_METHOD_FUNC(wrap_Sort_getValues), 0);
}
