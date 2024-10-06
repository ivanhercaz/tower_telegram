defmodule TowerTelegram.Reporter do
  @moduledoc false

  @default_level :error

  def report_event(%Tower.Event{level: level} = event) do
    if Tower.equal_or_greater_level?(level, level()) do
      do_report_event(event)
    end

    :ok
  end

  def do_report_event(%Tower.Event{} = e) do
    Telegex.send_message(
      chat_id(),
      build_message(e),
      parse_mode: "markdown"
    )

    :ok
  end

  defp build_message(%Tower.Event{
         kind: kind,
         reason: exception,
         stacktrace: stacktrace
       }) do
    """
    Tower received an error of kind `#{kind}`.

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

  defp include_hashtags(kind), do: "#tower\\_report #tower\\_type\\_#{kind}"

  defp level(), do: Application.get_env(:tower_telegram, :level, @default_level)

  defp chat_id(), do: Application.get_env(:tower_telegram, :chat_id)
end
