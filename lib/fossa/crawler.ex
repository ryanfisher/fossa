defmodule Fossa.Crawler do
  @http_client Fossa.HttpClient
  @doc """
  Starts a crawler at the given entry_point passing html response of each request
  to the process function.
  """
  def start(entry_point, process), do: start(entry_point, process, nil)
  def start(entry_point, process, precrawl) do
    entry_point
    |> URI.parse
    |> List.wrap
    |> crawl(MapSet.new, process, precrawl)
  end

  defp crawl([], _, _, _), do: nil # Kill process
  defp crawl([url | urls], crawled, process, precrawl) do
    if precrawl, do: precrawl.(url)
    if MapSet.member?(crawled, url) do
      crawl(urls, crawled, process, precrawl)
    else
      new_urls = urls ++ parse(url, process)
      IO.inspect new_urls
      crawl(new_urls, MapSet.put(crawled, url), process, precrawl)
    end
  end

  defp parse(url, process) do
    case request(URI.to_string(url)) do
      nil  -> []
      html ->
        html |> process.()
        html
        |> Fossa.Parser.internal_links(url)
    end
  end

  defp request(url) do
    :timer.sleep(1500)
    @http_client.request(url)
  end
end
