defmodule CredoRuntimeOnly.Check.Warning.SystemGetEnvTest do
  use Credo.TestHelper

  @described_check CredoRuntimeOnly.Check.Warning.SystemGetEnv

  test "it should NOT report violation using other System calls" do
    """
    defmodule IEx.Bar do
      System.argv()
      System.version()
    end
    """
    |> to_source_file()
    |> refute_issues(@described_check)
  end

  test "it should report violation calling System.get_env outside of a module" do
    """
    System.get_env("VARIABLE")
    """
    |> to_source_file()
    |> assert_issue(@described_check)
  end

  test "it should report violation calling System.get_env at module level" do
    """
    defmodule IEx.Bar do
      System.get_env("VARIABLE")
    end
    """
    |> to_source_file()
    |> assert_issue(@described_check)
  end

  test "it should report violation calling System.get_env at function level" do
    """
    defmodule IEx.Bar do
      def get_value do
        System.get_env("VARIABLE")
      end
    end
    """
    |> to_source_file()
    |> assert_issue(@described_check)
  end

  test "it should report all violations" do
    """
    defmodule IEx.Bar do
      def get_value do
        System.get_env("VARIABLE")
      end

      def get_other do
        System.get_env("VARIABLE")
      end
    end
    """
    |> to_source_file()
    |> assert_issues(@described_check)
  end

  test "it should NOT report calls to other functions called get_env" do
    """
    defmodule IEx.Bar do
      def get_env do
        "env variable"
      end

      def do_it do
        get_env
      end
    end
    """
    |> to_source_file()
    |> refute_issues(@described_check)
  end

  test "it should repot violations in Macro calls" do
    """
    defmodule IEx.Bar do
      use Mix.Config

      config :test_app, :test_value, System.get_env("VALUE")
    end
    """
    |> to_source_file()
    |> assert_issue(@described_check)
  end
end
