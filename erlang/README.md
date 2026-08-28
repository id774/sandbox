# Erlang

## Overview

Erlang is a functional, dynamically typed programming language built from the ground up for writing concurrent, distributed, and fault-tolerant software. It is closely associated with the BEAM virtual machine that executes it, and its process and messaging model has made it a long-standing reference point for how to build systems that keep running in the presence of partial failure.

## History

Erlang originated at Ericsson's computer science laboratory, where Joe Armstrong, Robert Virding, and Mike Williams developed it beginning in 1986 as proprietary internal technology. It was created to address the specific demands of telecommunications switching software: systems that had to handle enormous numbers of simultaneous, largely independent activities (such as concurrent phone calls), tolerate hardware and software faults without full outages, and in some cases be upgraded without being taken down. Existing languages of the time did not model this kind of massively concurrent, fault-tolerant, soft-real-time workload well, which motivated a language designed around those needs directly rather than added on afterward. Ericsson released Erlang as free and open-source software in 1998, after it had already been proven internally on telecom switching products.

## Language design and characteristics

Erlang is functional in style, favoring pattern matching and recursion over mutable state, and it is dynamically typed. Its defining characteristic, however, is its concurrency model: an Erlang program is organized as many independent, lightweight processes, each with its own isolated memory, that communicate solely by sending and receiving asynchronous messages rather than through shared memory or locks. These processes run on the BEAM virtual machine, which schedules potentially very large numbers of them concurrently. Because processes are isolated, a failure in one does not directly corrupt or block others, which underlies Erlang's "let it crash" philosophy: rather than writing defensive code to anticipate every possible error, a process is generally allowed to fail outright, and responsibility for noticing the failure and restarting the process is delegated to a separate supervising process. This produces supervision trees, in which supervisor processes monitor and restart the worker processes beneath them, giving the system a structured way to recover from errors automatically.

## Implementation and ecosystem

The "let it crash" model and its supervision trees are formalized in OTP, a set of Erlang libraries, design principles, and standard process behaviors for building applications that need to be reliable and maintainable in production. Erlang systems built on OTP can also take advantage of BEAM's support for distribution, connecting processes running on different machines as though they were part of the same system, and for hot code loading, which allows the code of a running system to be upgraded without stopping it.

## Uses and influence

Although Erlang was created for telecommunications switches, its concurrency and fault-tolerance model has carried it well beyond that original domain into other systems that need to stay available under heavy, unpredictable concurrent load, including messaging and chat infrastructure and message-queueing software. Its process-based, share-nothing approach to concurrency and its emphasis on isolating and recovering from failure rather than preventing it outright have also influenced the design of later languages and systems built on the same virtual machine, most notably Elixir.

## References

- [Wikipedia: Erlang (programming language)](https://en.wikipedia.org/wiki/Erlang_(programming_language))
