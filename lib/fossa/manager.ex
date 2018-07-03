defmodule Fossa.Manager do
  @moduledoc """
  A basic manager module to pass into crawler and handle each response
  """

  def process(html, _) do
    IO.puts(html)
  end
end
