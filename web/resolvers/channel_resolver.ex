defmodule Logs.ChannelResolver do
  def all(_args, _info) do
    {:ok, Logs.Channel.visible_channels }
  end

  def by_name(%{name: name}, _info) do
    {:ok, Logs.Channel.by_name(name) }
  end
end
