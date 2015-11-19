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
    # TODO: This is... a mess.
    # What it's trying to do is:
    # 1) If date isn't set, then find all messages for today
    # 2) If date is set, then find messages for that day
    # Is there a shorter way to get the beginning + end of the day in Elixir?
    # I would think so, given that the complexity of this code is quite high.
    case params["date"] do
      nil ->
        { date, time } = Timex.Date.now |> Timex.Date.Convert.to_erlang_datetime
        { :ok, start_time } = { date, { 0, 0, 0 } } |> Ecto.DateTime.load
      date ->
        {:ok, datetime } = Timex.DateFormat.parse(date, "%Y-%m-%d", :strftime)
        { date, time } = datetime |> Timex.Date.Convert.to_erlang_datetime
        start_time = { date, time } |> Ecto.DateTime.from_erl
    end

    end_time = { date, { 23, 59, 59 } } |> Ecto.DateTime.from_erl 

    channel = Repo.get_by(Channel, name: params["name"], hidden: false)

    query = from m in Message,
      where: m.channel_id == ^channel.id and
        m.created_at >= ^start_time and
        m.created_at <= ^end_time,
      order_by: m.created_at

    messages = query 
      |> Repo.all 
      |> Repo.preload([:person, :channel])

    { :ok, date } = Calendar.Date.from_erl(date)

    render conn, "show.html", channel: channel, messages: messages, date: date
  end
end
