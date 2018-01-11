# Fossa

A web crawler

## Usage

Given a url entry point, Fossa will continuously crawl links found in manner based on default or given strategy.

## Required Initialization Arguments

- `entry_point` the starting url
- `tag` a value to track a particular crawler

## Available Crawl Options

- `internal` defaults to false

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

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/fossa](https://hexdocs.pm/fossa).
