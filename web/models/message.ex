defmodule Logs.Message do
  use Ecto.Model

  schema "messages" do
    field :text
    field :type
    belongs_to :person, Logs.Person
    belongs_to :channel, Logs.Channel
    field :hidden, :boolean
    field :created_at, Calecto.DateTimeUTC
  end
end
