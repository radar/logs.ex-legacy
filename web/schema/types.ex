defmodule Logs.Schema.Types do
  use Absinthe.Schema.Notation

  object :channel do
    field :name, :string
    field :messages, list_of(:message)
  end

  scalar :timestamp do
    serialize &Calendar.Strftime.strftime!(&1, "%H:%M:%S")
  end

  object :message do
    field :id, :id
    field :text, :string
    field :type, :string
    field :person, :person
    field :created_at, :timestamp
  end

  object :person do
    field :nick, :string
  end
end
