require "mkmf"
have_library("stdc++")
$CPPFLAGS += " -std=c++11 "
$libs += " -lstdc++ "
create_makefile("sort")
