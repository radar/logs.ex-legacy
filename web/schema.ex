defmodule Logs.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern

  import_types Logs.Schema.Types


  query do
    field :channels, list_of(:channel) do
      resolve &Logs.ChannelResolver.all/2
    end

    field :channel, type: :channel do
      arg :name, non_null(:string)
      resolve &Logs.ChannelResolver.by_name/2
    end

    field :person, type: :person do
      arg :nick, non_null(:string)
      resolve &Logs.PersonResolver.by_nick/2
    end

    connection field :by_person, node_type: :message do
      arg :person, non_null(:string)
      resolve &Logs.MessageResolver.by_person/2
    end
  end
end
