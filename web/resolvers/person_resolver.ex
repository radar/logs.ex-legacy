defmodule Logs.PersonResolver do
  def by_nick(%{nick: nick}, _info) do
    {:ok, Logs.Repo.get_by(Logs.Person, nick: nick)}
  end
end
