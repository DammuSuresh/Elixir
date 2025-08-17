defmodule Avatar.MixProject do
  # import Mogrify
  use Mix.Project

  def project do
    [
      app: :avatar,
      version: "0.1.0",
      elixir: "~> 1.18.1",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies. 5432
  defp deps do
    [
      # {:egd, github: "erlang/egd"},
       {:mogrify, "~> 0.9.1"},
       {:ex_png, "~> 1.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
