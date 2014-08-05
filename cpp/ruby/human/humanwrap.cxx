
#include <new>
#include "ruby.h"
#include "human.hxx"

// function prototypes
extern "C" void Init_human();
static void   wrap_Human_free(Human* p);
static VALUE  wrap_Human_alloc(VALUE klass);
static VALUE  wrap_Human_init(VALUE self, VALUE _name, VALUE _age);
static VALUE  wrap_Human_toString(VALUE self);
static VALUE  wrap_Human_greet(VALUE self);
static VALUE  wrap_Human_getName(VALUE self);
static VALUE  wrap_Human_getAge(VALUE self);
static Human* getHuman(VALUE self);

static Human* getHuman(VALUE self) {
  Human* p;
  Data_Get_Struct(self, Human, p);
  return p;
}

static void wrap_Human_free(Human* p) {
  if (p->isLegal()) p->~Human();
  ruby_xfree(p);
}

static VALUE wrap_Human_alloc(VALUE klass) {
  return Data_Wrap_Struct(klass, NULL, wrap_Human_free, ruby_xmalloc(sizeof(Human)));
}

static VALUE wrap_Human_init(VALUE self, VALUE _name, VALUE _age) {
  const char* name = StringValuePtr(_name);
  int age = NUM2INT(_age);

  Human* p = getHuman(self);
  new (p) Human(name, age);

  return Qnil;
}

static VALUE wrap_Human_toString(VALUE self) {
  return rb_str_new2(getHuman(self)->toString().c_str());
}

static VALUE wrap_Human_greet(VALUE self) {
  return rb_str_new2(getHuman(self)->greet().c_str());
}

static VALUE wrap_Human_getName(VALUE self) {
  return rb_str_new2(getHuman(self)->getName().c_str());
}

static VALUE wrap_Human_getAge(VALUE self) {
  return INT2NUM(getHuman(self)->getAge());
}

void Init_human() {
  VALUE c = rb_define_class("Human", rb_cObject);

  rb_define_alloc_func(c, wrap_Human_alloc);
  rb_define_private_method(c, "initialize", RUBY_METHOD_FUNC(wrap_Human_init), 2);
  rb_define_method(c, "inspect", RUBY_METHOD_FUNC(wrap_Human_toString), 0);
  rb_define_method(c, "to_s", RUBY_METHOD_FUNC(wrap_Human_toString), 0);
  rb_define_method(c, "greet", RUBY_METHOD_FUNC(wrap_Human_greet), 0);
  rb_define_method(c, "name", RUBY_METHOD_FUNC(wrap_Human_getName), 0);
  rb_define_method(c, "age", RUBY_METHOD_FUNC(wrap_Human_getAge), 0);
}
