defmodule Logs.PersonController do
  use Logs.Web, :controller
  alias Logs.Person
  alias Logs.Channel
  alias Logs.Message
  alias Logs.Repo
  import Ecto.Query

  def most_active(conn, _params) do
    messages = from message in Message,
    join: person in assoc(message, :person),
    group_by: person.nick,
    select: [count(message.id), person.nick],
    order_by: [desc: count(message.id)],
    limit: 25
    
    messages = messages |> Repo.all

    render conn, "most_active.html", messages: messages


  end

  def show(conn, params) do

    person = Repo.get_by(Person, nick: params["nick"])

    page = Message
    |> where([m], m.person_id == ^person.id)
    |> where([m], m.hidden == false)

    if params["channel"] do
      channel = Repo.get_by(Channel, name: params["channel"], hidden: false)

      page = page |> where([m], m.channel_id == ^channel.id)
    end

    page = page |> order_by([m], desc: m.created_at)
    |> preload([:channel])
    |> Repo.paginate(page: params["page"], page_size: 250)

    channel_ids = Enum.map(page.entries, fn (m) -> m.channel_id end)
    channels = Channel |> where([c], c.id in ^channel_ids) |> Repo.all

    render conn, "show.html",
      person: person, messages: page.entries, channel: channel,
      page_number: page.page_number, total_pages: page.total_pages,
      channels: channels
  end

  def activity(conn, params) do
    person = Repo.get_by(Person, nick: params["nick"])

    query = from m in Message,
      where: m.person_id == ^person.id,
      select: min(m.created_at)
    { { oldest_year, _, _ }, _ } = query |> Repo.one

    query = from m in Message,
      where: m.person_id == ^person.id,
      select: max(m.created_at)
    { { most_recent_year, _, _ }, _ } = query |> Repo.one

    render conn, "activity.html",
      person: person,
      oldest_year: oldest_year,
      most_recent_year: most_recent_year
  end
end
