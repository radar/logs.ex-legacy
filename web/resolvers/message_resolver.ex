defmodule Logs.MessageResolver do
  alias Logs.{Channel, Message, Person, Repo}

  def by_channel(channel, %{date: date}, _info) do
    {:ok, Message.by_channel_and_date(channel.id, Date.from_iso8601!(date)) |> Repo.all}
  end

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
