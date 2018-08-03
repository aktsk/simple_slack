defmodule SimpleSlack.Mixfile do
  use Mix.Project

  def project do
    [app: :simple_slack,
     version: "1.0.0",
     elixir: "~> 1.7.1",
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
    [{:httpoison, "~> 1.2.0"},
     {:poison, "~> 4.0.1"},
     {:credo, ">= 0.10.0", runtime: false, only: :dev},
     {:ex_doc, ">= 0.19.0", runtime: false, only: :dev}]
  end

  defp package do
    [maintainers: ["Seizan Shimazaki"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/aktsk/simple_slack"},
     files: ~w(mix.exs README.md LICENSE lib)]
  end
end
