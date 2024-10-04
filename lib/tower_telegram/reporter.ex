defmodule TowerTelegram.Reporter do
  @moduledoc false

  @default_level :info

  def report_event(%Tower.Event{level: level} = event) do
    if Tower.equal_or_greater_level?(level, level()) do
      do_report_event(event)
    end
  end

  def do_report_event(%Tower.Event{
    kind: kind,
    id: id,
    reason: exception,
    stacktrace: stacktrace
  }) do
    # TODO: report event with Telegex
  end

  defp level() do
    Application.get_env(:tower_telegram, :level, @default_level)
  end
end
