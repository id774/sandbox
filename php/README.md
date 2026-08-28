# PHP

## Overview

PHP is a general-purpose scripting language oriented primarily toward server-side web development, designed so that code can be embedded directly inside HTML documents and executed on the server before the resulting page is sent to a client's browser. It is dynamically typed and has grown over successive versions to include a full set of object-oriented programming features alongside its original procedural style. PHP occupies a long-standing position in web application development, where it functions similarly to other server-side scripting technologies such as Python-based, ASP.NET, or JavaServer Pages solutions that generate dynamic content from a web server.

## History

PHP was created by Danish-Canadian programmer Rasmus Lerdorf, who began its development in 1993 by writing a set of Common Gateway Interface (CGI) programs in C to help him maintain his own personal home page, and publicly released the resulting tools in 1995. Lerdorf extended these programs so that they could process HTML forms and communicate with databases, naming the result "Personal Home Page/Forms Interpreter," or PHP/FI. A development team subsequently formed around the project, and after further work and beta testing, PHP/FI 2 was officially released in November 1997. Lerdorf has noted that the project grew organically out of practical needs rather than from any original intention to design a new programming language. As PHP matured, its name was reinterpreted as the recursive backronym "PHP: Hypertext Preprocessor," replacing its original "Personal Home Page" expansion and reflecting the tool's shift from a personal utility into a general-purpose language.

## Language design and characteristics

PHP is dynamically typed and is designed to be embedded within HTML markup, so that a single file can mix static HTML content with blocks of PHP code that the server executes to generate parts of the page dynamically. Over its version history the language has grown from a purely procedural scripting tool into one that also supports full object-oriented programming, alongside features such as namespaces and exception handling, while retaining its original procedural style as a fully supported way of writing code. PHP code is typically processed on a web server through a PHP interpreter that runs as a server module, a standalone daemon, or a Common Gateway Interface executable, giving it flexibility in how it is integrated into a given web server's request-handling pipeline.

## Implementation and ecosystem

At the core of the standard PHP implementation is the Zend Engine, a compiler and runtime environment consisting of a Zend Virtual Machine built from a Zend Compiler and a Zend Executor, which together compile PHP source code and execute it. The Zend Engine was first introduced with PHP version 4 in 1999 and has remained the foundation of the reference PHP interpreter since, which is distributed as free software. This reference implementation has been ported to run across a wide range of web servers and operating systems, which has been a significant factor in PHP's broad adoption for hosted web applications. Around the language, a substantial ecosystem of software frameworks has developed to support rapid, structured application development, including Laravel, Symfony, CodeIgniter, CakePHP, the Yii Framework, Phalcon, and Laminas, many of which rely on the Composer dependency manager to install and manage PHP packages.

## Uses and influence

PHP's original purpose of generating dynamic web pages has remained its central use case, and it has been used at very large scale as the language underlying widely deployed content management systems and web platforms. Its combination of easy HTML embedding, a low barrier to entry for simple scripts, and, in later versions, a mature object-oriented feature set, has kept it in wide use for building web applications ranging from small personal sites to large, framework-based systems, cementing its historical and ongoing role as one of the primary languages of server-side web development.

## References

- [Wikipedia: PHP](https://en.wikipedia.org/wiki/PHP)
