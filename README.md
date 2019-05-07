# CredoRuntimeOnly

A Credo lint to check for calls to `System.get_env`

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `credo_runtime_only` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:credo_runtime_only, "~> 0.1.0"}
  ]
end
```

After adding the package, you need to enable the check by adding the check to
the `.credo.exs` checks like so:
```elixir
%{
  configs: [
    checks: [
      {CredoRuntimeOnly.Check.Warning.SystemGetEnv},
      ...
    ]
  ]
}
```
