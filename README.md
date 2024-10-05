# TowerTelegram

Error tracking and reporting to a Telegram chat (group or channel).

It is a work-in-progress heavily inspired in the already existing
[`TowerEmail`][tower_email] structure,
but using Telegram and [`telegex` Telegram bot framework][telegex]

## Requirements

In order to use this reporter you must have a Telegram bot and provide
your bot token and the chat ID (group or channel) in which you need to
receive the reports.

## Configuration

This reporter uses `Telegex` for the communication with the bot. In order to use a Telegram bot, it is necessary
to specify the bot token for `Telegex`:

```elixir
config :telegex, token: "<BOT_TOKEN>"
```

In addition you must specify your preferred adapter for the HTTP client. At the moment of writting this, Telegex
supports `Finch` (recommended) and `HTTPoison`:

```elixir
# With Finch
config :telegex, caller_adapter: Finch

# With HTTPoison
config :telegex, caller_adapter: HTTPoison
```

Check [Telegex's Configuration section][telegex-config] for more options and information.

You must also add the `chat_id` in which you want to receive the reports:

```elixir
config :tower_telegram, chat_id: <chat_id>
```

TODO: add a helper to get the chat id (a simple wrapper around get_updates)

Finally, you must register the reporter in `tower` reporters list:

```elixir
config :tower, :reporters, [TowerTelegram]
```

[telegex]: https://github.com/telegex/telegex
[telegex-config]: https://github.com/telegex/telegex#configuration
[tower_email]: https://github.com/mimiquate/tower_email
