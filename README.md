# Fossa

A web crawler

## Usage

Given a url entry point, Fossa will continuously crawl links found in manner based on default or given strategy.

## Required Initialization Arguments

- `entry_point` the starting url

## Available Crawl Options

- `tag` a value to track a particular crawler
- `internal` defaults to false
- `process` a function of arity 2 that processes the html body of each response
- `precrawl` a function of arity 2 that is called prior to each request
- `data` extra data load to pass on to the precrawl and process functions

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `fossa` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:fossa, "~> 0.1.0"}
  ]
end
```

## Resources

- https://www.quora.com/What-are-the-best-web-crawling-services-Im-mainly-looking-for-services-that-provide-the-greatest-volume-of-aggregated-web-content-as-a-feed-upon-which-I-can-do-whatever-analytics-I-need
- Documentation on robots.txt https://en.wikipedia.org/wiki/Robots_exclusion_standard
- HN discussion on scraping https://news.ycombinator.com/item?id=22778089

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/fossa](https://hexdocs.pm/fossa).
