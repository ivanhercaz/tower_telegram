# TowerTelegram

![Hex.pm Version](https://img.shields.io/hexpm/v/tower_telegram) [![Documentation](https://img.shields.io/badge/-Documentation-blueviolet)](https://hexdocs.pm/nx) [![CI](https://github.com/ivanhercaz/tower_telegram/actions/workflows/ci.yml/badge.svg)](https://github.com/ivanhercaz/tower_telegram/actions/workflows/ci.yml)

Error tracking and reporting to a Telegram chat (group or channel) using [Tower][tower].

It is a work-in-progress heavily inspired in the already existing [`TowerEmail`][tower-email] structure, but using Telegram and [`telegex`][telegex].

## Requirements

In order to use this reporter you must have a Telegram bot and provide your bot token and the chat ID (group or channel) in which you need to receive the reports.

If you don't have or you don't know how to create a Telegram bot, first check [*How Do I Create a Bot*](https://core.telegram.org/bots#how-do-i-create-a-bot) Telegram's page.

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

Finally, you must register the reporter in `tower` reporters list:

```elixir
config :tower, :reporters, [TowerTelegram]
```

### Note

If you are interested in use TowerTelegram but with another Telegram packages, please, first read [this issue][tower-telegram-packages] and then feel free to open a new one requesting! Or even a pull request implementing the one you desire.

## Usage

Once you already have the reporter, it will listen the errors
of your application as it is explained in [`Tower` documentation][tower-docs].

It is also possible to manually fire the reporter, check *Manual
Handling* section of Tower's documentation.

## Test your bot reporter

Once you have `TowerTelegram` configured, you can open `iex` and
test it using `Tower.test/0`.

[telegex]: https://github.com/telegex/telegex

[telegex-config]: https://github.com/telegex/telegex#configuration

[tower]: https://github.com/mimiquate/tower

[tower-docs]: https://hexdocs.pm/tower

[tower-email]: https://github.com/mimiquate/tower_email

[tower-telegram-packages]: https://github.com/ivanhercaz/tower_telegram/issues/2
