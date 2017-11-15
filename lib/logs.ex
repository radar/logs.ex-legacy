defmodule Logs do
  alias Logs.{Message, Repo}
  def data() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(Message, %{date: date}) do
    Message |> Message.by_date(date)
  end

  def query(queryable, _params) do
    queryable
  end
end
