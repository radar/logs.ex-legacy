defmodule Logs.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  object :channel do
    field :name, :string
    field :messages, list_of(:message) do
      arg :date, :string
      resolve &Logs.MessageResolver.by_channel/3
    end
  end

  object :message do
    field :id, :id
    field :text, :string
    field :type, :string
    field :person, :person, resolve: dataloader(Logs)
    field :created_at, :string
  end

  object :person do
    field :nick, :string
  end

  connection node_type: :message
end
