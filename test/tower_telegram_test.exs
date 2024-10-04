defmodule TowerTelegramTest do
  use ExUnit.Case
  doctest TowerTelegram

  test "greets the world" do
    assert TowerTelegram.hello() == :world
  end
end
