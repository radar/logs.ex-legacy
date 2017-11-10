defmodule Logs.Schema.Types do
  use Absinthe.Schema.Notation

  object :channel do
    field :name, :string
    field :messages, list_of(:message)
  end

  object :message do
    field :id, :id
    field :text, :string
    field :type, :string
    field :person, :person
    field :created_at, :string
  end

  object :person do
    field :nick, :string
  end
end
