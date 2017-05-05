defmodule Logs.Message do
  alias Logs.Message
  alias Logs.Repo
  import Ecto.Query
  use Ecto.Schema

  schema "messages" do
    field :text
    field :type
    belongs_to :person, Logs.Person
    belongs_to :channel, Logs.Channel
    field :hidden, :boolean
    field :created_at, Ecto.DateTime
  end

  def by_channel_and_date(channel_id, date) do
    start_of_next_day = date |> Calendar.Date.advance!(1) |> Ecto.Date.cast! |> Ecto.DateTime.from_date
    start_of_day = date |> Ecto.Date.cast! |> Ecto.DateTime.from_date

    query = from m in Message,
      where: m.channel_id == ^channel_id and
        m.created_at >= ^start_of_day and
        m.created_at <  ^start_of_next_day,
      order_by: m.created_at

    query
      |> Repo.all
      |> Repo.preload(:person)
  end
end
