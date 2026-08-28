# Pig Latin

## Overview

Apache Pig is a platform for creating programs that process very large datasets on top of Apache Hadoop. Pig Latin is the data-flow language the platform provides for writing those programs: Pig itself is the runtime and execution engine, while Pig Latin is the language a programmer actually writes in. A Pig Latin script is compiled by Pig into a series of jobs that run on a distributed backend, so the distinction between the platform and its language is central to how the project is described.

## History

Apache Pig originated inside Yahoo Research around 2006, where it was built to give researchers an ad hoc way to write and run MapReduce jobs against very large datasets without programming directly against the lower-level Java MapReduce interface. In 2007 the project was moved out of Yahoo and into the Apache Software Foundation, which has maintained it since as part of the wider family of tools that grew up around Hadoop.

## Architecture and characteristics

A Pig Latin program expresses a computation as a sequence of transformation steps rather than as a single declarative query: a script typically loads data and then filters, groups, joins, and aggregates it before storing the result. Individual operators mirror familiar relational operations — FILTER BY acts like a SQL selection, GROUP collects rows that share a key into nested groups without aggregating them itself, and a following FOREACH ... GENERATE step performs the actual projection and aggregation over those groups — alongside JOIN, UNION, DISTINCT, and ORDER operators with their conventional meanings. Because a script can branch, a Pig Latin program is more precisely described as a directed acyclic graph of steps rather than a strictly linear pipeline. Pig's engine compiles this graph into jobs that can run on MapReduce, Apache Tez, or Apache Spark, which allows the same script to target more than one underlying execution system. The language can be extended with user-defined functions written in Java, Python, JavaScript, Ruby, or Groovy and called directly from Pig Latin code. Wikipedia frames Pig Latin's relationship to SQL as a contrast in style rather than a close correspondence: SQL is declarative and leaves an optimizer to choose how a query executes, while Pig Latin is procedural, with the script itself laying out the sequence of steps — closer to specifying an execution plan by hand — which gives a programmer direct control over the flow of a data-processing task, including splitting a data stream and applying different operations to each branch, something SQL has no built-in way to do.

## Ecosystem and use

Pig sits within the broader Hadoop ecosystem alongside other Apache projects such as Hive and HBase, offering a script-based, higher-level alternative to writing MapReduce jobs by hand against large stored datasets.

## References

- [Wikipedia: Apache Pig](https://en.wikipedia.org/wiki/Apache_Pig)
