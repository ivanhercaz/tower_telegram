defmodule TowerTelegram do
  @moduledoc """
  Telegram reporter for `Tower` error handler.

  In order to use this reporter you must have a Telegram bot and provide
  your bot token and the chat ID (group or channel) in which you need to
  receive the reports.
  """

  @behaviour Tower.Reporter

  @impl true
  def report_event(event), do: TowerTelegram.Reporter.report_event(event)
end
