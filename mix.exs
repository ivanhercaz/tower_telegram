defmodule TowerTelegram.MixProject do
  use Mix.Project

  def project do
    [
      app: :tower_telegram,
      version: "0.2.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      name: "TowerTelegram",
      source_url: "https://github.com/ivanhercaz/tower_telegram",
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tower, "~> 0.6.0"},
      {:telegex, "~> 1.8.0"},
      {:finch, "~> 0.19.0", optional: true},
      {:httpoison, "~> 2.2", optional: true},
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      main: "TowerTelegram",
      extras: ["README.md"]
    ]
  end

  defp package do
    [
      description:
        "Error tracking and reporting to a Telegram chat (group or channel) using Tower.",
      files: ~w(lib LICENSE mix.exs README.md CHANGELOG.md),
      licenses: ["Apache-2.0"],
      links: %{
        "GitHub" => "https://github.com/ivanhercaz/tower_telegram",
        "Tower package" => "https://hex.pm/packages/tower"
      }
    ]
  end
end
