# -*- coding: utf-8 -*-

class Parent(object):
    def show(self):
        self.stdout()

    def stdout(self):
        print("hoge")

class Child(Parent):
    def stdout(self):
        print("childoge")

if __name__ == "__main__":
    parent = Parent()
    parent.show()
    child = Child()
    child.show()
