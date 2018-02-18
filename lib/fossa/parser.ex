defmodule Fossa.Parser do
  def internal_links(body, url) do
    body
    |> Floki.find("a[href]")
    |> Floki.attribute("href")
    |> Enum.map(&(Fossa.Utils.URI.prepend_host(&1, url)))
  end
end
