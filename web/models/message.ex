defmodule Logs.Message do
  alias Logs.Message
  import Ecto.Query
  use Ecto.Schema

  schema "messages" do
    field :text
    field :type
    belongs_to :person, Logs.Person
    belongs_to :channel, Logs.Channel
    field :hidden, :boolean
    field :created_at, :naive_datetime
  end

  def by_person(person) do
    Message
      |> where(person_id: ^person.id)
      |> where(hidden: false)
  end

  def descending(query) do
    query |> order_by(desc: :created_at)
  end

  def by_date(query, date) do
    time = ~T[00:00:00]
    {:ok, until} = date |> Calendar.Date.advance!(1) |> NaiveDateTime.new(time)
    {:ok, from} = NaiveDateTime.new(date, time)

    from m in query,
      where: m.created_at >= ^from and m.created_at <  ^until,
      order_by: m.created_at
  end

  def by_channel(query, channel_id) do
    from m in query, where: m.channel_id == ^channel_id
  end
end
