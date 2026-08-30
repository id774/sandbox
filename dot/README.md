# Graphviz DOT

## Overview

DOT is a plain-text language for describing the structure of a graph: its nodes, the edges connecting them, and the attributes that annotate either. It is the description language used by the Graphviz project, and it is purely declarative, meaning a DOT file states what a graph consists of without specifying how that graph should be laid out visually. Computing an actual drawing from a DOT description, including the positions of nodes and the routing of edges, is left entirely to separate programs rather than being part of the language itself.

## History

DOT was developed as part of the Graphviz project, which originated at AT&T Bell Labs. The project traces back to work by researchers including Eleftherios Koutsofios and Stephen North on tools for automatically drawing graphs to support software engineering tasks, with an early technical report on the subject appearing in 1991. Over the following years the DOT format was formalized into the plain-text graph description language that Graphviz tools use as their common input format.

## Architecture and characteristics

A DOT file describes either a directed graph, written with the `digraph` keyword and edges pointing from one node to another, or an undirected graph, written with the `graph` keyword and edges that simply connect two nodes without direction. Within such a description, nodes and edges can be grouped into subgraphs, and subgraphs whose names follow a specific convention are treated as clusters, causing the layout engine to draw their members visually grouped together. Attributes can be attached to graphs, nodes, and edges alike to control properties such as labels, colors, and shapes, but these attributes describe intent rather than exact coordinates. This division of labor is central to DOT's design: the language itself only captures a graph's logical structure and desired styling, while the work of computing an actual geometric layout is handled entirely outside the language, by whichever program reads the DOT file.

## Ecosystem and use

Graphviz supplies several distinct programs that read DOT descriptions and compute a layout from them, each suited to different kinds of graphs: the dot tool produces layered, hierarchical drawings well suited to directed graphs such as flowcharts, neato and fdp use force-directed, spring-model layouts more suited to undirected graphs, circo produces circular layouts, and twopi produces radial ones. These tools render the resulting layout into common output formats such as SVG, PNG, PDF, and PostScript. Because DOT is a simple, human-readable and easily machine-generated text format, it is widely used as a target output format by other software, letting programs emit DOT files as a straightforward way to visualize dependency graphs, state machines, call graphs, and other structures, and as a documentation aid wherever a diagram needs to be generated automatically rather than drawn by hand.

## References

- [Wikipedia: DOT (graph description language)](https://en.wikipedia.org/wiki/DOT_(graph_description_language))

## Layout

- `choose.dot`: the one standalone Graphviz source file in this directory;
  its header comment records the install and render commands it is meant to
  be used with.
