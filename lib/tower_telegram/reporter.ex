defmodule TowerTelegram.Reporter do
  @moduledoc false

  @default_level :error

  def report_event(%Tower.Event{level: level} = event) do
    if Tower.equal_or_greater_level?(level, level()),
      do: do_report_event(event)
  end

  def do_report_event(%Tower.Event{} = event) do
    Telegex.send_message(
      chat_id(),
      build_message(event),
      parse_mode: "markdown"
    )

    :ok
  end

  defp build_message(%Tower.Event{
         kind: kind,
         reason: exception,
         stacktrace: stacktrace
       }) do
    {module, function} = from(stacktrace)

    """
    Tower received an error of kind `#{kind}` from the function `#{function}` of the module `#{module}`.

    *Reason*:
    ```elixir
    #{inspect(exception)}
    ```
    *Stacktrace*:
    ```elixir
    #{inspect(stacktrace)}
    ```
    #{include_hashtags(kind)}
    """
  end

  defp from([head | _]), do: from(head)

  defp from({module, function, parameters, _}),
    do: {format_module(module), format_function(function, parameters)}

  defp format_module(module), do: Atom.to_string(module)

  defp format_function(function, 0), do: Atom.to_string(function) <> "/0"

  defp format_function(function, parameters) when is_list(parameters),
    do: Atom.to_string(function) <> "/" <> Integer.to_string(Enum.count(parameters))

  defp include_hashtags(kind), do: "#tower\\_report #tower\\_type\\_#{kind}"

  defp level(), do: Application.get_env(:tower_telegram, :level, @default_level)

  defp chat_id(), do: Application.get_env(:tower_telegram, :chat_id)
end
