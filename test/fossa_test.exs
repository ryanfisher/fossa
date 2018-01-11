defmodule FossaTest do
  use ExUnit.Case
  doctest Fossa

  test "greets the world" do
    assert Fossa.hello() == :world
  end
end
