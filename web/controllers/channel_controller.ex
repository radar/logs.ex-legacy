defmodule Logs.ChannelController do
  use Logs.Web, :controller
  alias Logs.Channel
  alias Logs.Person
  alias Logs.Message
  alias Logs.Repo
  import Ecto.Query

  def index(conn, _params) do
    channels = Channel
      |> where([c], c.hidden == false)
      |> Repo.all
    render conn, "index.html", channels: channels
  end

  def show(conn, params) do
    channel = Repo.get_by(Channel, name: params["name"], hidden: false)

    date = case params["date"] do
      nil ->
        DateTime.now!("Etc/UTC") |> DateTime.to_date
      date_from_params ->
        date_from_params |> Date.Parse.iso8601!
    end
    next_day = date |> Date.advance!(1)
    start_time = DateTime.from_date_and_time_and_zone!(date,     {0, 0, 0}, "Etc/UTC")
    end_time   = DateTime.from_date_and_time_and_zone!(next_day, {0, 0, 0}, "Etc/UTC")

    query = from m in Message,
      where: m.channel_id == ^channel.id and
        m.created_at >= ^start_time and
        m.created_at <  ^end_time,
      order_by: m.created_at

    messages = query
      |> Repo.all
      |> Repo.preload(:person)

    render conn, "show.html", channel: channel, messages: messages, date: date
  end
end
