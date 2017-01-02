defmodule ElixirLinearAlgebra.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_linear_algebra,
     version: "0.9.2",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp package do
    [name: :ela,
     files: ["lib", "test", "mix.exs", "README*", "LICENSE*"],
     links: %{"GitHub" => "https://github.com/SebastianCallh/elixir-linear-algebra"},
     licenses: ["MIT License"],  
     maintainers: ["Sebastian Callh"]]
  end

  defp description do
    """
    Elixir Linear Algebra (ELA for short) contains functionality for working with both vectors and matrices. 
    """
  end
end
