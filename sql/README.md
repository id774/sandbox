# SQL

## Overview

SQL is a declarative language for working with data held in relational database systems, used to define the structure that data is stored in, to query and modify it, and to control how changes are grouped and made permanent. Rather than specifying, step by step, how to retrieve or update records, an SQL statement describes the result a user wants, such as the rows that satisfy a condition, and leaves the database system to determine how to produce it. SQL operates on entire sets of rows at once rather than one record at a time, which is one of the properties that distinguished it from the record-at-a-time data access methods it succeeded.

## History

SQL grew directly out of the relational model of data that Edgar F. Codd described in a 1970 paper while working at IBM, which proposed organizing data into relations, or tables, and manipulating them through operations grounded in mathematical set theory and predicate logic rather than through navigational, pointer-based access. Building on Codd's ideas, IBM researchers Donald D. Chamberlin and Raymond F. Boyce developed a query language they called SEQUEL, for Structured English Query Language, in the early 1970s as part of IBM's System R project, an experimental relational database system built to test whether the relational model could be implemented practically and efficiently. The language was later renamed SQL after a trademark conflict with the original name, and it retained the core query and data-manipulation capabilities Chamberlin and Boyce had designed. Because it could operate on many rows with a single command rather than requiring an application to step through records individually, as older access methods such as ISAM and VSAM did, SQL offered a significant productivity advantage over the data-access techniques it competed with.

## Language design and characteristics

SQL is conventionally divided by the roles its statements play: a data definition portion for creating and altering the structure of tables and other database objects, a data manipulation portion for inserting, updating, deleting, and retrieving rows, a set of constraint mechanisms for enforcing rules such as uniqueness or referential integrity on the data, and transaction-control statements for grouping operations so that they succeed or fail together. Its query facilities are built around the relational operations that follow from Codd's model: selecting rows that meet a condition, projecting particular columns, joining rows from multiple tables based on related values, aggregating rows into summary values such as counts or sums, and nesting one query inside another as a subquery to express more complex conditions. The `SELECT` statement, combined with clauses for filtering, joining, grouping, and ordering, is the primary vehicle through which these operations are expressed.

## Implementation and ecosystem

SQL was standardized by the American National Standards Institute in 1986 and by the International Organization for Standardization shortly afterward, and the standard has been revised repeatedly since then to add new capabilities while preserving the language's core. In practice, however, no two database products implement the standard identically: vendors extend SQL with their own procedural and functional additions, producing dialects with their own names and idioms, so that code written for one relational database system frequently needs adjustment before it will run unchanged on another, even though the shared core of the standard keeps the languages broadly similar.

## Uses and influence

SQL functions as the primary interface to the great majority of relational database management systems in use today, serving as the common language through which applications define schemas, insert and retrieve data, enforce integrity rules, and manage transactions regardless of which particular database product is underneath. That central, standardized role, resting on ongoing revision by ANSI and ISO even as vendors layer their own dialects on top, is a large part of why SQL has remained the dominant way of interacting with relational data since its introduction.

## References

- [Wikipedia: SQL](https://en.wikipedia.org/wiki/SQL)

## Layout

- `harddrive_analysis`: scripts and SQL for loading Backblaze's published
  hard-drive test-data CSVs into a table.
- `postgresql`: a script that sets up a local PostgreSQL role and database
  for development.
