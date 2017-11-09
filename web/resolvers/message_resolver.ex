defmodule Logs.MessageResolver do
  def by_channel(%{name: name}, _info) do
    channel = Logs.Channel.by_name(name)
    date = "2017-11-08"
    {:ok, Logs.Message.by_channel_and_date(channel.id, Date.from_iso8601!(date)) }
  end

  def by_name(%{name: name}, _info) do
    {:ok, Logs.Channel.by_name(name) }
  end
end
