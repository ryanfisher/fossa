defmodule Fossa.Utils.URI do
  import Enum, only: [member?: 2]
  @web_page_ext ["", ".html", ".html", ".php"]
  @accepted_schemes ["http", "https", nil]
  @doc """
  Prepends the host when given a relative path, does nothing with absolute

  ## Examples

    iex> Fossa.Utils.URI.prepend_host("/resume.html", "https://ryanfisher.io")
    "https://ryanfisher.io/resume.html"
    iex> Fossa.Utils.URI.prepend_host("http://pantryio.com/recipes", "https://pantryio.com")
    "http://pantryio.com/recipes"
  """
  def prepend_host(href, url) do
    %URI{host: site_host} = URI.parse(url)
    %URI{host: host, scheme: scheme} = URI.parse(href)
    if accepted_scheme?(scheme) && member?([site_host, nil], host) do
      url |> URI.merge(href) |> URI.to_string
    else
      false
    end
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

  defp accepted_scheme?(scheme) do
    member?(@accepted_schemes, scheme)
  end
end
