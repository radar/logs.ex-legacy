defmodule Logs.Mixfile do
  use Mix.Project

  def project do
    [app: :logs,
     version: "0.0.1",
     elixir: "~> 1.3",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Logs.Application, []},
      extra_applications: [:logger, :dataloader, :absinthe]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 1.3.0"},
     {:phoenix_ecto, "~> 3.3.0"},
     {:corsica, "~> 1.0"},
     {:postgrex, "~> 0.13"},
     {:phoenix_html, "~> 2.7"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:cowboy, "~> 1.0"},
     {:scrivener, "~> 2.1.1"},
     {:scrivener_ecto, "~> 1.1.3"},
     {:calendar, "~> 0.17.2"},
     {:absinthe, "~> 1.4.0"},
     {:absinthe_plug, "~> 1.4.0"},
     {:absinthe_relay, "~> 1.4.0"},
     {:dataloader, "~> 1.0.0"},
     {:distillery, "~> 1.5.2"},
     {:edeliver, "~> 1.4.4"},
   ]
  end
end
