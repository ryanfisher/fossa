defmodule Fossa.Parser do
  @moduledoc """
  Parses body responses
  """

  def internal_links(body, url) do
    body
    |> hrefs(url)
    |> Enum.filter(&Fossa.Utils.URI.same_host?(&1, url))
  end

  @doc """
  All href values in body string

  ## Examples

    iex> Fossa.Parser.hrefs(~s(<html><body><a href="https://ryanfisher.io">link</a></body></html>))
    [%URI{authority: "ryanfisher.io", host: "ryanfisher.io", port: 443, scheme: "https"}]
  """
  def hrefs(body, url \\ nil) do
    body
    |> Floki.find("a[href]")
    |> Floki.attribute("href")
    |> Enum.map(&URI.parse/1)
    |> Enum.map(&Fossa.Utils.URI.set_host(&1, url))
  end
end
