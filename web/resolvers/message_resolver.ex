defmodule Logs.MessageResolver do
  alias Logs.{Channel, Message, Person, Repo}

  def paginated(pagination_args = %{person: nick}, _info) do
    Person
    |> Repo.get_by(nick: nick)
    |> Message.by_person
    |> Message.descending
    |> Absinthe.Relay.Connection.from_query(
         &Repo.all/1,
         pagination_args
    )
  end

  def by_channel(channel, %{date: date}, _info) do
    {:ok, Message.by_channel_and_date(channel.id, Date.from_iso8601!(date)) |> Repo.all}
  end

  def by_person(%{nick: nick, page: page}) do
    messages = Repo.get_by(Person, nick: nick)
    |> Message.by_person
    |> Message.descending
    |> Repo.paginate(page: page, page_size: 250)

    messages.entries
  end
end
