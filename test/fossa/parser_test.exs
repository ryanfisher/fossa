defmodule Fossa.ParserTest do
  use ExUnit.Case

  doctest Fossa.Parser

  test "should append given url host for relative links" do
    url = %URI{authority: "ryanfisher.io", host: "ryanfisher.io", port: 443, scheme: "https"}
    body = ~s(
      <html><body>
        <a href="https://ryanfisher.io">link</a>
        <a href="/resume">resume</a>
      </body></html>
    )
    assert Fossa.Parser.hrefs(body, url) == [
      %URI{authority: "ryanfisher.io", host: "ryanfisher.io", port: 443, scheme: "https"},
      %URI{host: "ryanfisher.io", path: "/resume", scheme: "https"}
    ]
  end
end
