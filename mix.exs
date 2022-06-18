defmodule ExBalena.Mixfile do
  use Mix.Project

  @source_url "https://github.com/basement-lab/ex_balena"
  @version "0.1.0"

  def project do
    [
      app: :ex_balena,
      version: @version,
      elixir: "~> 1.0",
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps()
    ]
  end

  def package do
    [
      maintainers: "derekclair",
      licenses: ["MIT"],
      links: %{
        "GitHub" => @source_url
      },
      files: ["lib", "test", "mix.exs"]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def deps do
    [
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:finch, "~> 0.9.1"},
      {:jason, "~> 1.2"},
      {:mimic, "~> 1.5", only: :test},
      {:tesla, "~> 1.4"}
    ]
  end
end
