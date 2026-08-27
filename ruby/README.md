# Ruby

Ruby is a dynamically typed, object-oriented programming language designed around expressive syntax and developer productivity. It treats values as objects and makes extensive use of blocks, iterators, metaprogramming, and a flexible object model, with common uses in scripting and web development.

As described on [Wikipedia](https://en.wikipedia.org/wiki/Ruby_(programming_language)), Yukihiro "Matz" Matsumoto began developing Ruby in the mid-1990s in Japan and released the first version on December 21, 1995, citing Perl, Smalltalk, Eiffel, Ada, BASIC, and Lisp as influences. Everything in Ruby is an object, including primitive data types, and by 2000 the language was already more popular in Japan than Python, with English-language adoption widening after the book Programming Ruby was later released freely online.

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
