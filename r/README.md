# R

## Overview

R is a programming language and free software environment built specifically for statistical computing and graphics. It centers on a vectorized data model, in which operations apply naturally across whole arrays of values, together with statistical and graphical facilities aimed at data analysis rather than general application programming.

## History

R originated with statisticians Ross Ihaka and Robert Gentleman, who began developing it at the University of Auckland in the early 1990s as a language for teaching introductory statistics; a binary was first posted publicly to the StatLib archive in August 1993. It was conceived as an implementation of the S language, developed earlier at AT&T Bell Laboratories around 1975, and most S programs run in R largely unaltered, while R's lexical scoping was instead influenced by the Scheme dialect of Lisp. The language's name plays on both its status as an S successor and the shared initial of its two creators' first names.

## Language design and characteristics

R's core structure for tabular data is the data frame, and the language provides a formula notation — introduced together with the data frame in the 1991 "White Book" — that lets statistical models be written in a compact symbolic form rather than as explicit code. R offers two parallel systems for object orientation, S3 and S4: S3 is informal and dispatches methods based on a single object's class attribute, while S4 formally declares a class's representation and inheritance and can dispatch a method based on the classes of several arguments at once. Its scoping is lexical, in the manner of Scheme, giving R's functions access to variables from their enclosing environment and supporting a functional style of programming.

## Implementation and ecosystem

R is free and open-source software released under the GNU General Public License and distributed as part of the GNU Project; its main implementation, maintained by the R Core Team, is written primarily in C, Fortran, and R itself, runs as an interpreted language with a native command-line interface, and is available as precompiled builds for Linux, macOS, and Windows. Third-party interfaces built on top of it include the RStudio integrated development environment and Jupyter notebooks. The core language is extended by a very large collection of user-contributed packages distributed through the Comprehensive R Archive Network (CRAN), founded in 1997, which by mid-2025 hosted tens of thousands of packages across dozens of mirrors; the tidyverse collection of packages for transforming, visualizing, and modeling data is among the most widely used of these.

## Uses and influence

R is used broadly across statistics, data mining, data analysis, and data science, and it has a particularly prominent role in bioinformatics through projects such as Bioconductor, which supplies R packages for genomic and other high-throughput biological data analysis; it is reported to rank among the ten most widely used programming languages.

## References

- [Wikipedia: R (programming language)](https://en.wikipedia.org/wiki/R_(programming_language))

R experiments covering plotting, statistics, and data handling.

## Layout

Files directly under this directory are short scripts on language basics and file
or network I/O.

Subdirectories group experiments by library or theme:

- Cross-language exercise sets: `basics` and `math`, described in the
  repository [README](../README.md#the-basics-directory). The six files of the
  `math` set sit among the older snippets already in `math`.
- Plotting and mapping: `ggplot2`, `ggmap3`, `plot`
- Statistics and analysis: `stats`, `igraph`, `MachineLearning`

## Notes

Snippets target whichever R and package versions were current when they were
written, so some no longer run as is. See the repository [README](../README.md) for
the sandbox policy.
