#include <new>
#include <ruby.h>
#include "hello.h"                                                                                                                                                                                                    

static Hello* getHello(VALUE self)
{
  Hello* p;
  Data_Get_Struct(self, Hello, p); 
  return p;
}

static void wrap_Hello_free(Hello* p)
{
  p->~Hello();
  ruby_xfree(p);
}

static VALUE wrap_Hello_alloc(VALUE klass)
{
  void* p = ruby_xmalloc(sizeof(Hello));
  new (p) Hello(); // replacement newにより初期化しておかないとnewに失敗しとき(引数の数が違うとか)デストラクタ呼び出しで死ぬ
  return Data_Wrap_Struct(klass, NULL, wrap_Hello_free, p); 
}

static VALUE wrap_Hello_init(VALUE self)
{
  Hello* p = getHello(self);
  new (p) Hello();

  return Qnil;
}

static VALUE wrap_Hello_sayHello(VALUE self)
{
  getHello(self)->sayHello();

  return Qnil;
}

/**
 * require時に呼び出し
 */
extern "C" void Init_hello()
{
  VALUE c = rb_define_class("Hello", rb_cObject);

  rb_define_alloc_func(c, wrap_Hello_alloc);
  rb_define_private_method(c, "initialize", RUBY_METHOD_FUNC(wrap_Hello_init), 0); 
  rb_define_method(c, "say_hello", RUBY_METHOD_FUNC(wrap_Hello_sayHello), 0); 
}