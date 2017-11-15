defmodule Logs.MessageResolver do
  alias Logs.{Message, Repo}

  def paginated(person, pagination_args, _info) do
    person
    |> Message.by_person
    |> Message.descending
    |> Absinthe.Relay.Connection.from_query(
         &Repo.all/1,
         pagination_args
    )
  end
end
