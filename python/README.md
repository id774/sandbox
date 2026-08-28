# Python

## Overview

Python is a high-level, general-purpose programming language distinguished by an emphasis on code readability and a comparatively compact syntax. It is dynamically typed and interpreted, combines strong typing with duck typing, and supports procedural, object-oriented, and functional styles within a single language.

## History

Python's design began in the late 1980s with Guido van Rossum at the Centrum Wiskunde & Informatica (CWI) research institute in the Netherlands, with implementation starting in December 1989. Van Rossum had previously spent several years working on the ABC programming language, and ABC's design was a major influence on Python's own. He first published the language's code publicly in February 1991 as Python 0.9.0, by which point it already included classes with inheritance, exception handling, functions, and core data types such as list, dict, and str; the name Python was chosen after the British comedy group Monty Python, whose work Van Rossum enjoyed. The language's most consequential later event was the release of Python 3.0 in December 2008, a deliberately backward-incompatible revision meant to correct design flaws that could not be fixed while keeping full compatibility with the Python 2 line. The resulting transition was long: Python 2 continued to receive releases until version 2.7.18 in 2020, and later Python 3 releases shipped a 2to3 conversion utility to help migrate existing code.

## Language design and characteristics

Python uses indentation, rather than braces or keywords, to delimit blocks, reflecting a broader design philosophy that favors readability and generally prefers a single, obvious way to perform a given task. Variables are not declared with fixed types; type checking happens at run time, and Python is generally described as strongly typed even though that checking is dynamic rather than static, with duck typing used to judge whether an object suits a given purpose by the methods and attributes it provides rather than by its declared type. Its object model treats everything — including functions, classes, and modules, not only ordinary data — as an object. On top of this base, the language accommodates procedural code, object-oriented code built around classes and inheritance, and functional-style code using constructs such as first-class functions.

## Implementation and ecosystem

Python's memory management combines automatic reference counting with a cycle-detecting garbage collector, so most objects are freed as soon as their reference count reaches zero while the collector separately reclaims reference cycles that counting alone cannot free. CPython, written in a combination of C and Python, is the language's reference implementation and remains its default and most widely used one; alternative implementations include PyPy, which uses just-in-time compilation and frequently runs faster than CPython, and Jython, which targets the Java Virtual Machine and lets Python code use Java classes directly. Language development proceeds mainly through the Python Enhancement Proposal (PEP) process, in which proposals for new features or documented design decisions are reviewed by the community and overseen by a Steering Council; the nonprofit Python Software Foundation, launched in March 2001, supports this process, holds the language's intellectual property, funds development work, and organizes events such as PyCon. Third-party distribution runs through the Python Package Index (PyPI), also known as the Cheese Shop, which by 2025 hosted several hundred thousand packages.

## Uses and influence

Python is used as a general-purpose scripting language for automation and small programs, as a language for web development, and, through its data-science ecosystem, for scientific computing, data analysis, and machine learning; its extensive standard library and its suitability for adding programmable interfaces to existing applications are commonly cited as reasons for its adoption in these areas.

## References

- [Wikipedia: Python (programming language)](https://en.wikipedia.org/wiki/Python_(programming_language))

Python experiments, from small language exercises to library and framework trials.

## Layout

Files directly under this directory are single-topic exercises on language and
standard library behavior, such as generators, argument forms, and date handling.

Subdirectories group experiments by library or theme:

- Cross-language exercise sets: `basics` and `math`, described in the
  repository [README](../README.md#the-basics-directory). The six files of the
  `math` set sit among the older snippets already in `math`.
- Web frameworks and servers: `bottle`, `cherrypy`, `flask`, `web.py`,
  `simplemeserv`, `apache2`, `xml-rpc`
- Numeric and scientific: `numpy`, `scipy`, `pandas`, `statsmodels`, `talib`,
  `simpy`, `mpi4py`
- Machine learning: `chainer`, `tensorflow`, `sklearn`, `machine-learning`,
  `decision_tree`, `naivebayes`, `cluster`, `networkx`, `huggingface`
- Text processing and NLP: `MeCab`, `CaboCha`, `nlp`, `text-mining`, `BeautifulSoup`
- Plotting and imaging: `matplotlib`, `pylab`, `pil`
- Data formats and messaging: `csv`, `json`, `config`, `email`, `sendgrid`
- Databases and interop: `sqlalchemy`, `libvirt`, `r`
- Standard library and tooling: `doctest`, `nose`, `distutils`, `optparse`,
  `subprocess`, `loadpath`
- GUI and browser automation: `tkinter`, `webdriver`

## Notes

Snippets target whichever interpreter and library versions were current when they
were written, so some no longer run as is. See the repository [README](../README.md)
for the sandbox policy.
