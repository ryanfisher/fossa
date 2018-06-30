defmodule Fossa.HttpClient do
  @moduledoc """
  Http client for making requests
  """

  def request(url) when is_bitstring(url) do
    IO.puts("Requesting: #{url}")
    with %HTTPoison.Response{body: body, status_code: 200} <- HTTPoison.get! url do
      if String.valid?(body), do: body, else: nil
    else
      _ -> nil
    end
  rescue
    _ in HTTPoison.Error -> ""
  end
  def request(_), do: ""
end
