#!/usr/bin/env python3
# -*- coding: utf-8 -*-

class Klass:
    __x = 10

    def __init__(self, value):
        self.member1 = value
        self._member2 = value
        self.__member3 = value

instance = Klass("ahaha")

print("member1=", instance.member1)
print("member2=", instance._member2)
print("member3=", instance._Klass__x)
print("member3=", instance._Klass__member3)

class ABC:

    def __init__(self):
        self._x = 1
        self.__y = 2

abc = ABC()

print "_x =", abc._x
print "__y =", abc._ABC__y
print dir(abc)
