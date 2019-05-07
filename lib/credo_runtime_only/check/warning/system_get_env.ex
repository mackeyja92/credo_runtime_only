defmodule CredoRuntimeOnly.Check.Warning.SystemGetEnv do
  @moduledoc false

  @checkdoc """
  Checks for calls to System.get_env/0/1. Calls to this are compile time lookups instead of Runtime lookups.

  In most cases, runtime lookups are desired and compile time lookups should be avoided.
  """

  @explanation [check: @checkdoc]
  @callstring "System.get_env"

  use Credo.Check, base_priority: :high

  @doc false
  def run(source_file, params \\ []) do
    issue_meta = IssueMeta.for(source_file, params)

    Credo.Code.prewalk(source_file, &traverse(&1, &2, issue_meta))
  end

  defp traverse(
         {{:., _, [{:__aliases__, _, [:System]}, :get_env]}, meta, _arguments} = ast,
         issues,
         issue_meta
       ) do
    {ast, issues_for_call(meta, issues, issue_meta)}
  end

  defp traverse(ast, issues, _issue_meta) do
    {ast, issues}
  end

  defp issues_for_call(meta, issues, issue_meta) do
    [issue_for(issue_meta, meta[:line], @callstring) | issues]
  end

  defp issue_for(issue_meta, line_no, trigger) do
    format_issue(
      issue_meta,
      message: "There should be no calls to System.get_env/0 or System.get_env/1",
      trigger: trigger,
      line_no: line_no
    )
  end
end
