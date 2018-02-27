defmodule Fossa.Parser do
  def internal_links(body, url) do
    body
    |> Floki.find("a[href]")
    |> Floki.attribute("href")
    |> Enum.map(&URI.parse/1)
    |> Enum.map(&Fossa.Utils.URI.set_host(&1, url))
    |> Enum.filter(&Fossa.Utils.URI.same_host?(&1, url))
  end
end
