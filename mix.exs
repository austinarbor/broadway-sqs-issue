defmodule BroadwayIssue.MixProject do
  use Mix.Project

  def project do
    [
      app: :broadway_issue,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [mod: {Example.Application, []}, extra_applications: [:logger, :runtime_tools]]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.2"},
      {:hackney, "~> 1.17"},
      {:sweet_xml, "~> 0.6"},
      {:ex_aws_sqs, "~> 3.3.1"},
      {:broadway_sqs, "~> 0.7"}
    ]
  end
end
