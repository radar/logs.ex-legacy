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
      |> where(person_id: ^person.id)
      |> where(hidden: false)

    if params["channel"] do
      channel = Repo.get_by(Channel, name: params["channel"], hidden: false)

      page = page |> where(channel_id: ^channel.id)
    end

    page = page |> order_by(desc: :created_at)
    |> preload([:channel])
    |> Repo.paginate(page: params["page"], page_size: 250)

    channel_ids = Enum.map(page.entries, fn (m) -> m.channel_id end) |> Enum.uniq
    channels = (from c in Channel, where: c.id in ^channel_ids) |> Repo.all

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

    %{year: oldest_year} = query |> Repo.one

    query = from m in Message,
      where: m.person_id == ^person.id,
      select: max(m.created_at)
    %{year: most_recent_year} = query |> Repo.one

    render conn, "activity.html",
      person: person,
      oldest_year: oldest_year,
      most_recent_year: most_recent_year
  end
end
