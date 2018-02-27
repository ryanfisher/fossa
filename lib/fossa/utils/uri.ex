defmodule Fossa.Utils.URI do
  import Enum, only: [member?: 2]
  @web_page_ext ["", ".html", ".html", ".php"]
  @doc """
  Set host and scheme from given url

  ## Examples

    iex> Fossa.Utils.URI.set_host(URI.parse("/home.html"), URI.parse("https://pantryio.com/home.html"))
    %URI{scheme: "https", host: "pantryio.com", path: "/home.html"}
  """
  def set_host(href, url) do
    href
    |> Map.put(:host, href.host || url.host)
    |> Map.put(:scheme, href.scheme || url.scheme)
  end

  @doc """
  Checks if the given url looks like a web page

  ## Examples

    iex> Fossa.Utils.URI.potential_web_page?("/resume.pdf")
    false
    iex> Fossa.Utils.URI.potential_web_page?("/resume.html")
    true
    iex> Fossa.Utils.URI.potential_web_page?(nil)
    false
  """
  def potential_web_page?(url) when is_bitstring(url) do
    @web_page_ext
    |> member?(Path.extname(url))
  end
  def potential_web_page?(_), do: false

  @doc """
  Checks if urls share the same host and scheme

  ## Examples

    iex> uri1 = URI.parse("https://pantryio.com")
    iex> uri2 = URI.parse("https://ryanfisher.io")
    iex> Fossa.Utils.URI.same_host?(uri1, uri2)
    false
    iex> uri3 = URI.parse("https://pantryio.com/recipes")
    iex> Fossa.Utils.URI.same_host?(uri1, uri3)
    true
  """
  def same_host?(%URI{host: next_host, scheme: next_scheme}, %URI{host: host, scheme: scheme}) do
    next_host == host && next_scheme == scheme
  end
end
