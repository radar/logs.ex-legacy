defmodule Logs.TipController do
  use Logs.Web, :controller
  alias Logs.Tip
  alias Logs.Repo
  import Ecto.Query

  def index(conn, _params) do
    tips = Tip
    |> order_by([t], asc: t.command)
    |> Repo.all
    render conn, "index.html", tips: tips
  end
end
