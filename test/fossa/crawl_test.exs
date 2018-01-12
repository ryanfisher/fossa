defmodule Fossa.CrawlTest do
  use ExUnit.Case, async: true
  doctest Fossa.Crawl

  setup do
    {:ok, crawl_server} = start_supervised Fossa.Crawl
    %{server: crawl_server}
  end

  test "starts process to crawl", %{server: server} do
    assert Fossa.Crawl.start(server, %{
      entry_point: "https://ryanfisher.io",
      tag: "ryanfisher"
    }) == %{"ryanfisher" => true}
  end
end
