defmodule Logs.MessageResolver do
  alias Logs.{Channel, Message, Person, Repo}
  def by_channel(%{name: name, date: date}, _info) do
    channel = Channel.by_name(name)
    {:ok, Message.by_channel_and_date(channel.id, Date.from_iso8601!(date)) }
  end

  def by_person(%{nick: nick}, _info) do
    messages = Repo.get_by(Person, nick: nick)
    |> Message.by_person
    |> Message.descending
    |> Repo.paginate(page: 1, page_size: 250)

    {:ok, messages.entries}
  end
end
