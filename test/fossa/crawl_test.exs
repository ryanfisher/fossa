defmodule Fossa.CrawlTest do
  use ExUnit.Case, async: true
  doctest Fossa.Crawl

  setup do
    {:ok, crawl_server} = Fossa.Crawl.start_link
    %{server: crawl_server}
  end

  test "starts process to crawl", %{server: _} do
    assert Fossa.Crawl.start(%{
      entry_point: "https://ryanfisher.io",
      tag: "ryanfisher"
    }) == %{"ryanfisher" => true}
  end
end
