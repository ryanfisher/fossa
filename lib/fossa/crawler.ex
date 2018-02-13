defmodule Fossa.Crawler do
  def start(entry_point, manager) do
    [entry_point]
    |> crawl(MapSet.new, manager)
  end

  defp crawl([], _, _), do: nil # Kill process
  defp crawl([url | urls], crawled, manager) do
    if MapSet.member?(crawled, url) do
      crawl(urls, crawled, manager)
    else
      crawl(urls ++ parse(url, manager), MapSet.put(crawled, url), manager)
    end
  end

  defp parse(url, manager) do
    case request(url) do
      nil  -> []
      html ->
        html |> manager.process
        html |> Fossa.Parser.internal_links
    end
  end

  defp request(url) do
    :timer.sleep(1500)
    Fossa.HttpClient.request(url)
  end
end
