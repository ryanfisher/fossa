defmodule Fossa.Mixfile do
  use Mix.Project

  def project do
    [
      app: :fossa,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      env: [request_delay: 1000] # In microseconds
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:httpoison, "~> 0.11"},
      {:floki, "~> 0.20.0"},
      {:credo, "~> 0.9.1", only: [:dev, :test], runtime: false},
    ]
  end
end
