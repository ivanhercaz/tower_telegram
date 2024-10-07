defmodule TowerTelegramTest do
  use ExUnit.Case
  doctest TowerTelegram

  import ExUnit.CaptureLog, only: [capture_log: 1]

  setup do
    bypass = Bypass.open()

    Application.put_env(:tower, :reporters, [TowerTelegram])
    Application.put_env(:tower_telegram, :chat_id, "chat-id")
    Application.put_env(:telegex, :api_base_url, "http://localhost:#{bypass.port}/")
    Application.put_env(:telegex, :token, "fake-token")

    {:ok, bypass: bypass}
  end

  test "reports exception", %{bypass: bypass} do
    # ref message synchronization trick copied from
    # https://github.com/PSPDFKit-labs/bypass/issues/112
    parent = self()
    ref = make_ref()

    Bypass.expect_once(bypass, "POST", "/botfake-token/sendMessage", fn conn ->
      {:ok, body, conn} = Plug.Conn.read_body(conn)

      assert(
        %{
          "chat_id" => "chat-id",
          "parse_mode" => "markdown",
          "text" => text
        } = Jason.decode!(body)
      )

      assert String.starts_with?(text, "Tower received an error")
      assert String.match?(text, ~r/ArithmeticError/)
      assert String.match?(text, ~r/bad argument/)

      send(parent, {ref, :sent})

      conn
      |> Plug.Conn.put_resp_content_type("application/json")
      |> Plug.Conn.resp(200, Jason.encode!(%{"ok" => true}))
    end)

    capture_log(fn ->
      Task.start(fn ->
        1 / 0
      end)
    end)

    assert_receive({^ref, :sent}, 500)
  end
end
