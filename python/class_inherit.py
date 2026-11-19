# -*- coding: utf-8 -*-
# class_inherit.py: Override a parent method in a subclass
#
# Description:
# Override a parent method in a subclass and call it through the parent.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 class_inherit.py
#
# Requirements:
# - Python 3
#

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
