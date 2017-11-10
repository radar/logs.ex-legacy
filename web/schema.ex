defmodule Logs.Schema do
  use Absinthe.Schema

  import_types Logs.Schema.Types

  query do
    field :channels, list_of(:channel) do
      resolve &Logs.ChannelResolver.all/2
    end

    field :channel, type: :channel do
      arg :name, non_null(:string)
      resolve &Logs.ChannelResolver.by_name/2
    end

    field :messages, list_of(:message) do
      arg :name, non_null(:string)
      arg :date, non_null(:string)
      resolve &Logs.MessageResolver.by_channel/2
    end
  end
end
