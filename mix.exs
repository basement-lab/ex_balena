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
      source_url: @source_url,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  def application do
    []
  end

  defp description,
    do:
      "A utility for interfacing with the Balena Supervisor API's, either remotely, or from within a container host."

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

  defp deps do
    [
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:finch, "~> 0.9.1"},
      {:jason, "~> 1.2"},
      {:mimic, "~> 1.5", only: :test},
      {:tesla, "~> 1.4"}
    ]
  end
end
