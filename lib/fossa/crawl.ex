defmodule Fossa.Crawl do
  use GenServer
  @moduledoc """
  Controls for starting and stopping of crawl.
  """

  @process_name :fossa_crawl

  @doc """
  Start crawl server.
  """
  def start_link do
    IO.puts "Starting Fossa.Crawl"
    GenServer.start_link(__MODULE__, :ok, name: @process_name)
  end

  @doc """
  Start crawl.
  """
  def start(opts) do
    GenServer.call(server_pid(), {:start, opts})
  end

  ## Server Callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:start, opts}, _from, tags) do
    if Map.has_key?(tags, opts[:tag]) do
      {:reply, tags, tags}
    else
      # This will track a crawl supervisor pid
      tags = Map.put(tags, opts[:tag], true)
      {:reply, tags, tags}
    end
  end

  defp server_pid do
    Process.whereis(@process_name)
  end
end
