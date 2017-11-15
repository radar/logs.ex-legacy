defmodule Logs do
  def data() do
    Dataloader.Ecto.new(Logs.Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end
end
