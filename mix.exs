defmodule Presentex.Mixfile do
  use Mix.Project

  def project do
    [app: :presentex,
     version: "0.0.5",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     name: "Presentex",
     description: description,
     source_url: "https://github.com/Cobenian/presentex",
     package: package
     ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
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
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:earmark, "~> 0.1", only: :dev},
     {:ex_doc, "~> 0.7", only: :dev}]
  end

  defp description do
    """
    An Elixir -> HTML/JavaScript presentation generation tool.
    """
  end

  defp package do
      [# These are the default files included in the package
       files: ["lib", "files", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*", "*LICENSE"],
       contributors: ["Bryan Weber"],
       licenses: ["Apache 2.0"],
       links: %{"GitHub" => "https://github.com/Cobenian/Presentex"}]
  end

end
