defmodule Logs.ChannelView do
  use Logs.Web, :view

  def render("index.json", %{channels: channels}) do
    channels
  end
end

defimpl Poison.Encoder, for: Logs.Channel do
  def encode(channel, _options) do
    %{
      name: channel.name,
    } |> Poison.Encoder.encode([])
  end
end  
