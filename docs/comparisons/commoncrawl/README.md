# Python-Ray-Super Comparative Study against CommonCrawl

These directories contain the **source scripts**, so that others may
replicate the findings summarized
[here](https://github.com/starpit/super/tree/comparisons/docs/blogs/2-Super-CommonCrawl#performance-comparisons). There
are three separate sub-studies, all against
[CommonCrawl](https://commoncrawl.org) data:

- [**wordcount**](wordcount) classifies crawled web pages by contained
  words. This is a traditional word count against the WET files.

- [**webservers**](webservers) classifies crawled web pages by the
  serving web server. This classification operates against the WAT
  files.

- [**languages**](languages) classifies crawled web pages by supported
  languages. This classification operates against the CDX files.