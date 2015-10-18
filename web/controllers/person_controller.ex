defmodule Logs.PersonController do
  use Logs.Web, :controller
  alias Logs.Person
  alias Logs.Message
  alias Logs.Repo
  import Ecto.Query

  def show(conn, params) do

    person = Repo.get_by(Person, nick: params["nick"])

    page = Message
    |> where([m], m.person_id == ^person.id)
    |> where([m], m.hidden == false)
    |> order_by([m], desc: m.created_at)
    |> Repo.paginate(page: params["page"], page_size: 250)
    |> Repo.preload(:channel)

    render conn, "show.html",
      person: person, messages: page.entries,
      page_number: page.page_number, total_pages: page.total_pages

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
