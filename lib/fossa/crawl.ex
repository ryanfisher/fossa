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
    case validate_keys(opts) do
      [] -> {:ok, GenServer.call(server_pid(), {:start, opts})}
      errors -> {:error, errors}
    end
  end

  def validate_keys(opts) do
    [
      unless Map.has_key?(opts, :entry_point) do
        "Please include a :entry_point key with a url value at which to start your crawl."
      end
    ]
    |> Enum.filter(&(&1 != nil))
  end

  ## Server Callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:start, opts}, _from, tags) do
    tag = opts[:tag] || opts[:entry_point]

    if Map.has_key?(tags, tag) do
      {:reply, tags, tags}
    else
      # This will track a crawl supervisor pid
      {:ok, pid} =
        Task.start_link(Fossa.Crawler, :start, [
          opts[:entry_point],
          opts[:process] || (&Fossa.Manager.process/1),
          opts[:precrawl]
        ])

      tags = Map.put(tags, tag, pid)
      {:reply, tags, tags}
    end
  end

  defp server_pid do
    Process.whereis(@process_name)
  end
end
