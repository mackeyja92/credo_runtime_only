defmodule CredoRuntimeOnly.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :credo_runtime_only,
      name: "CredoRuntimeOnly",
      description:
        "A check to ensure there are no compile time variables used across an Elixir project.",
      version: @version,
      elixir: "~> 1.7",
      start_permanent: false,
      deps: deps(),
      package: package(),
      source_url: github_url(),
      home_page: github_url(),
      docs: [
        main: "readme",
        api_reference: false,
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.0"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp package do
    [
      name: "credo_runtime_only",
      licenses: ["MIT"],
      links: %{"GitHub" => github_url()}
    ]
  end

  defp github_url() do
    "https://github.com/mackeyja92/credo_runtime_only"
  end
end
