# Ruby

## Overview

Ruby is a general-purpose, dynamically typed programming language built around the idea that every value, including numbers and other primitives, is an object that responds to messages. It supports procedural, object-oriented, and functional styles at once, and its syntax favors readability and concision over ceremony. The language is most closely associated with scripting tasks and, later, web application development, where its expressiveness and its blocks-and-iterators style of collection handling are frequently cited as distinguishing traits.

## History

Ruby originated with Yukihiro "Matz" Matsumoto, who began sketching the language in Japan in 1993 out of dissatisfaction with the scripting languages then available, wanting something that felt more genuinely object-oriented than Perl while remaining practical for everyday text-processing and system tasks. He drew on a range of earlier languages for ideas, most notably Perl, Smalltalk, Eiffel, Ada, and Lisp, blending Perl's utility as a scripting tool with the object model of Smalltalk. The first public release went out in December 1995, and Matsumoto continued to guide the language's design for years afterward. Ruby's user base grew first within Japan, where it had an active community and documentation well before it was well known elsewhere; international adoption lagged until English-language material, including a freely available reference book, made the language accessible to a wider audience.

## Language design and characteristics

Ruby is dynamically typed, so variables carry no fixed type and type checking happens at run time rather than compile time. Its object model is pervasive: classes, modules, numbers, and even nil are objects, and behavior is invoked uniformly by sending messages to them. Blocks are one of the language's signature features, small chunks of code that can be passed to methods and are the mechanism behind Ruby's iterator-based approach to loops and collection processing; blocks, together with the `Proc` and `lambda` constructs, give the language closures that capture their surrounding scope. Ruby also has an unusually open and flexible object model: classes can be reopened and modified after they are first defined, modules can be mixed into classes to share behavior without single-inheritance restrictions, and extensive metaprogramming facilities let code define methods, intercept message sends, and alter classes at run time. This combination is part of what made frameworks that generate behavior dynamically, rather than through boilerplate, practical in Ruby.

## Implementation and ecosystem

The reference implementation, generally known as Matz's Ruby Interpreter or CRuby, is the version most commonly distributed and used, and it has for some time compiled Ruby source to bytecode for an internal virtual machine before execution. A number of alternative implementations exist alongside it that aim for different goals, such as running on other managed runtimes or improving performance, targeting platforms like the Java Virtual Machine or providing embeddable interpreters for constrained environments. Around the language sits RubyGems, the standard packaging and distribution system that lets developers publish and install reusable libraries, known as gems, and that has become the conventional way Ruby projects declare and pull in their dependencies.

## Uses and influence

Ruby is used for general-purpose scripting and automation as well as for building larger applications, but its most consequential impact on adoption came through Ruby on Rails, a web application framework whose release in the mid-2000s introduced many developers outside Japan to the language and popularized conventions such as favoring sensible defaults over configuration. The success of Rails drove a marked increase in Ruby's international visibility and use for web development in the years that followed, even as the language continued to be used more broadly for scripting and tooling work outside the web context.

## References

- [Wikipedia: Ruby (programming language)](https://en.wikipedia.org/wiki/Ruby_(programming_language))

Ruby experiments, from language exercises to gem trials and small applications.

## Layout

Files directly under this directory are single-topic exercises on language and
core library behavior, such as blocks, closures, and string handling.

Subdirectories group experiments by library or theme:

- Cross-language exercise sets: `basics` and `math`, described in the
  repository [README](../README.md#the-basics-directory). The six files of the
  `math` set sit among the older snippets already in `math`.
- Web frameworks and applications: `rails`, `sinatra`, `rack`, `activerecord`
- Scraping and feeds: `anemone`, `cosmicrawler`, `nokogiri`, `scraping`,
  `open-uri`, `rss`, `mixi2rss`
- External service clients: `facebook`, `github_twitter_bot`,
  `streaming_api`, `tfav2httm`, `sagawa`, `stock`
- Infrastructure and daemons: `aws`, `bluemix`, `hadoop`, `fluentd`,
  `eventmachine`, `daemon`, `monitor`, `sysadmin`, `log`
- Data stores and serialization: `mongo`, `redis`, `cassandra`, `csv`, `json`,
  `xml`, `yaml`, `msgpack`, `excel`
- Language features: `enumerable`, `lambda`, `lazy`, `unique-symbol`,
  `narray`
- Text processing and machine learning: `MeCab`, `CaboCha`, `okura`,
  `text-mining`, `machine-learning`, `naivebayes`
- Mail: `mail`, `tmail`
- Testing frameworks: `rspec`, `minitest`
- Interop and miscellany: `python`, `rsruby`, `graphviz`, `automaticruby`,
  `bugs`, `etc`, `old`

## Notes

Snippets target whichever interpreter and gem versions were current when they were
written, so some no longer run as is. See the repository [README](../README.md) for
the sandbox policy.
