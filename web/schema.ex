defmodule Logs.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema

  def context(ctx) do
    loader =
      Dataloader.new
      |> Dataloader.add_source(Logs, Logs.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

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
  end
end
