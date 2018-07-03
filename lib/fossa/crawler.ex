defmodule Fossa.Crawler do
  @moduledoc """
  Handles crawling and tracking crawled urls
  """

  @http_client Fossa.HttpClient
  @doc """
  Starts a crawler at the given entry_point passing html response of each request
  to the process function.
  """
  def start(entry_point, process), do: start(entry_point, process, nil)
  def start(entry_point, process, args) do
    entry_point
    |> URI.parse
    |> List.wrap
    |> crawl(MapSet.new, process, args)
  end

  defp crawl([], _, _, _), do: nil # Kill process
  defp crawl([url | urls], crawled, process, args) do
    if args[:precrawl], do: args[:precrawl].(url, args[:data])
    if MapSet.member?(crawled, url) do
      crawl(urls, crawled, process, args)
    else
      new_urls = urls ++ parse(url, process, args[:data])
      crawl(new_urls, MapSet.put(crawled, url), process, args)
    end
  end

  defp parse(url, process, data) do
    case request(URI.to_string(url)) do
      nil  -> []
      html ->
        html |> process.(data)
        html
        |> Fossa.Parser.internal_links(url)
    end
  end

  defp request(url) do
    :timer.sleep(1500)
    @http_client.request(url)
  end
end
