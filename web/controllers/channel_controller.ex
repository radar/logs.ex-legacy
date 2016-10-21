defmodule Logs.ChannelController do
  use Logs.Web, :controller
  alias Logs.Channel
  alias Logs.Message
  alias Logs.Repo
  import Ecto.Query

  def index(conn, _params) do
    channels = Channel |> where(hidden: false) |> Repo.all
    render conn, "index.html", channels: channels
  end

  def show(conn, params) do
    channel = Repo.get_by(Channel, name: params["name"], hidden: false)

    date = case params["date"] do
      nil ->
        DateTime.utc_now |> DateTime.to_date
      date_from_params ->
        date_from_params |> Date.from_iso8601!
    end

    start_of_next_day = date |> Calendar.Date.advance!(1) |> Ecto.Date.cast! |> Ecto.DateTime.from_date
    start_of_day = date |> Ecto.Date.cast! |> Ecto.DateTime.from_date

    query = from m in Message,
      where: m.channel_id == ^channel.id and
        m.created_at >= ^start_of_day and
        m.created_at <  ^start_of_next_day,
      order_by: m.created_at

    messages = query
      |> Repo.all
      |> Repo.preload(:person)

    render conn, "show.html", channel: channel, messages: messages, date: date
  end
end
