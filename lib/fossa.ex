defmodule Fossa do
  @moduledoc """
  Documentation for Fossa.
  """
  use Application

  @doc """
  Start the Fossa application
  """
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Fossa.Crawl, [])
    ]
    opts = [strategy: :one_for_one, name: Fossa.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
