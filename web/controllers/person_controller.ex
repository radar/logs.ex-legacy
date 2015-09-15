defmodule Logs.PersonController do
  use Logs.Web, :controller
  alias Logs.Person
  alias Logs.Message
  alias Logs.Repo
  import Ecto.Query

  def show(conn, params) do
    person = Repo.get_by(Person, nick: params["nick"])
    messages = from m in Message,
      where: m.person_id == ^person.id,
      order_by: [desc: m.created_at]

    messages = messages |> Repo.all
    render conn, "show.html", person: person, messages: messages
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

    # TODO: is there a way to use the same connection as Ecto does?
    {:ok, pid} = Postgrex.Connection.start_link(hostname: "localhost", database: "railsbot")
    result = Postgrex.Connection.query!(pid, "SELECT COUNT(*) as count, created_at::DATE as date FROM messages WHERE person_id = 9 GROUP BY created_at::DATE ORDER BY date DESC", [])
    render conn, "activity.html", 
      person: person, 
      activity: result.rows,
      oldest_year: oldest_year,
      most_recent_year: most_recent_year
  end
end
