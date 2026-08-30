# Play Framework

## Overview

Play Framework is an open-source web application framework for the Java Virtual Machine, used to build server-side web applications and APIs. It can be written in either Java or Scala, as well as other languages that compile to JVM bytecode.

## History

Play was created by developer Guillaume Bort while he worked at the French company Zenexity, later renamed Zengularity; pre-release versions of the project were already downloadable from Zenexity's site as early as 2007, although the earliest builds are no longer archived online. Support for writing applications in Scala was added starting with version 1.1. The framework changed substantially with version 2.0, when its core was rewritten in Scala, its build and deployment tooling moved to SBT, and its templating system switched from Apache Groovy to Scala.

## Architecture and characteristics

Play follows the model-view-controller pattern and is organized around convention over configuration, so a project's layout and naming follow built-in defaults rather than requiring explicit setup. It aims to support developer productivity through hot code reloading, which lets a running application reflect source changes immediately and display errors directly in the browser instead of requiring a restart. Since the version 2 rewrite, Play applications run on a built-in Akka HTTP or Netty server rather than a conventional servlet container, which lets the framework service long-running requests asynchronously without tying up a thread for the whole request — unlike Java EE frameworks that do not use the asynchronous support introduced by the Servlet 3.0 specification. Play 2 was also designed to be fully RESTful, with no server-side session bound to a particular connection, and it includes most of what is needed to build APIs without relying on separate add-ons.

## Ecosystem and use

Because it runs on the JVM and can be written in Java or Scala, Play sits within the broader Java and Scala ecosystem while deliberately avoiding a Java EE-centric application model. Wikipedia lists corporate users including Coursera, HuffPost, Hootsuite, Janrain, LinkedIn, and Connectifier, and notes that Play ranked among the most popular Scala projects on GitHub at points in 2013 and 2015. Its principal use is building server-side web applications and REST APIs.

## References

- [Wikipedia: Play Framework](https://en.wikipedia.org/wiki/Play_Framework)

## Layout

- `myfirstapp`, `myfirstapp2`: two generated Play Framework project trees
  (`README`, `app`, `build.sbt`, `conf`, `project`, `public`, `test`), left
  with the layout the framework generated, per `doc/POLICY.md` Section 3.4.
