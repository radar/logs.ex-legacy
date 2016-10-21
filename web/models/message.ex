defmodule Logs.Message do
  use Ecto.Schema
  use Calecto.Schema, usec: true


  schema "messages" do
    field :text
    field :type
    belongs_to :person, Logs.Person
    belongs_to :channel, Logs.Channel
    field :hidden, :boolean
    field :created_at, Ecto.DateTime
  end
end
