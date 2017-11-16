defmodule Logs.ChannelController do
  use Logs.Web, :controller

  alias Logs.Channel
  alias Logs.Message
  alias Logs.Repo

  def index(conn, _params) do
    render conn, "index.html", channels: Channel.visible_channels
  end

  def show(conn, %{"name" => name, "date" => date}) do
    conn
    |> show_messages(Channel.by_name(name), date |> Date.from_iso8601!)
  end

  def show(conn, %{"name" => name}) do
    channel = Channel.by_name(name)
    date = DateTime.utc_now |> DateTime.to_date
    conn |> show_messages(channel, date)
  end

  defp show_messages(conn, channel, date) do
    messages =
    Message
    |> Message.by_channel(channel.id)
    |> Message.by_date(date)
    |> Repo.all

    render conn, "show.html", channel: channel, messages: messages, date: date
  end
end
