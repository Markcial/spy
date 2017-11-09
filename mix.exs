defmodule Spy.Mixfile do
  use Mix.Project

  def project do
    [
      app: :spy,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Spy",
      source_url: "https://github.com/markcial/spy"
    ]
  end

  defp description() do
    "Elixir ssh agent management via port and bash calls"
  end

  defp package() do
    [
      # This option is only needed when you don't want to use the OTP application name
      name: "spy",
      # These are the default files included in the package
      files: ["config", "lib", "test", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Marc Garcia Sastre"],
      licenses: ["MIT License"],
      links: %{"GitHub" => "https://github.com/markcial/spy"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Spy.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
