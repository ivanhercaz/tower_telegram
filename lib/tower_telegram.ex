defmodule TowerTelegram do
  @moduledoc """
  Telegram reporter for `Tower` error handler.

  In order to use this reporter you must have a Telegram bot and provide
  your bot token and the chat ID (group or channel) in which you need to
  receive the reports.

  ## Configuration

  In your `config/config.exs` file:

  ```elixir
  # Set the token for the bot to use
  config :telegex, token: "<BOT_TOKEN>"

  # Set the chat ID in which the bot must post the reports
  config :tower_telegram, chat_id: <chat_id>

  # Register the tower reporter
  config :tower, :reporters, [TowerTelegram]
  ```

  ## Usage

  Once you already have the reporter, it will listen the errors
  of your application as it is explained in [`Tower`] documentation.

  It is also possible to manually fire the reporter, check *Manual
  Handling* section of Tower's documentation.

  ## Test your bot reporter

  Once you have `TowerTelegram` configured, you can open `iex` and
  test it using `Tower.test/0`.
  """

  @behaviour Tower.Reporter

  @impl true
  def report_event(event), do: TowerTelegram.Reporter.report_event(event)
end
