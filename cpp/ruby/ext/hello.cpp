// hello.cpp: Hello class implementation
//
// Description:
// Implement the Hello class, whose sayHello method prints hello. hello_wrp.cpp
// exposes it to Ruby.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//

#include "hello.h"                                                                                                                                                                                                    
#include <stdio.h>

Hello::Hello()
{

}

Hello::~Hello()
{

}

void Hello::sayHello()
{
  printf("hello\n");
}