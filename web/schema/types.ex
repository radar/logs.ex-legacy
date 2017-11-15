defmodule Logs.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

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
    connection field :messages, node_type: :message do
      resolve &Logs.MessageResolver.paginated/3
    end
  end

  connection node_type: :message
end
