defmodule Fossa.CrawlTest do
  use ExUnit.Case, async: true
  doctest Fossa.Crawl

  setup do
    {:ok, crawl_server} = Fossa.Crawl.start_link
    %{server: crawl_server}
  end

  test "starts process to crawl", %{server: _} do
    {:ok, %{"ryanfisher" => pid}} = Fossa.Crawl.start(%{
      entry_point: "https://ryanfisher.io",
      tag: "ryanfisher"
    })
    assert is_pid(pid)
  end

  test "validates that required keys are included" do
    assert Fossa.Crawl.start(%{}) |> elem(0) == :error
  end
end
