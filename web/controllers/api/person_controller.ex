defmodule Logs.API.PersonController do
  use Logs.Web, :controller
  alias Logs.Person
  alias Logs.Repo

  def activity(conn, params) do
    person = Repo.get_by(Person, nick: params["nick"])
    # TODO: is there a way to use the same connection as Ecto does?
    { :ok, result } = Ecto.Adapters.SQL.query(Repo, "SELECT COUNT(*) as count, created_at::DATE as date FROM messages WHERE person_id = #{person.id} GROUP BY created_at::DATE", [])

    render conn, activity: result.rows
  end
end
