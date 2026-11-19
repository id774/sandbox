// hello.h: Hello class declaration
//
// Description:
// Declare the Hello class used by the hello Ruby extension.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//

#ifndef __HELLO_H_
#define __HELLO_H_

class Hello
{
  public:
    Hello();
    virtual ~Hello();
    void sayHello();
};

#endif
