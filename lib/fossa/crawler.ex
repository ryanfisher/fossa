defmodule Fossa.Crawler do
  @http_client Fossa.HttpClient
  @doc """
  Starts a crawler at the given entry_point passing html response of each request
  to the process function of the given manager module.
  """
  def start(entry_point, manager) do
    [URI.parse(entry_point)]
    |> crawl(MapSet.new, manager)
  end

  defp crawl([], _, _), do: nil # Kill process
  defp crawl([url | urls], crawled, manager) do
    if MapSet.member?(crawled, url) do
      crawl(urls, crawled, manager)
    else
      new_urls = urls ++ parse(url, manager)
      IO.inspect new_urls
      crawl(new_urls, MapSet.put(crawled, url), manager)
    end
  end

  defp parse(url, manager) do
    case request(URI.to_string(url)) do
      nil  -> []
      html ->
        html |> manager.process
        html
        |> Fossa.Parser.internal_links(url)
    end
  end

  defp request(url) do
    :timer.sleep(1500)
    @http_client.request(url)
  end
end
