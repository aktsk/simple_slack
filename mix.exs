defmodule SimpleSlack.Mixfile do
  use Mix.Project

  def project do
    [app: :simple_slack,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     description: "Very simple slack client using incoming webhooks.",
     package: package()]
  end

  def application do
    [applications: [:httpoison, :logger, :poison],
     mod: {SimpleSlack, []}]
  end

  defp deps do
    [{:httpoison, ">= 0.9.0"},
     {:poison, ">= 2.2.0"},
     {:credo, ">= 0.4.8", only: :dev},
     {:ex_doc, ">= 0.13.0", only: :dev}]
  end

  defp package do
    [maintainers: ["Seizan Shimazaki"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/aktsk/simple_slack"},
     files: ~w(mix.exs README.md LICENSE lib)]
  end
end
