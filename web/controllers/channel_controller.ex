defmodule Logs.ChannelController do
  use Logs.Web, :controller
  alias Logs.Channel
  alias Logs.Repo

  def index(conn, _params) do
    render conn, "index.html", channels: Repo.all(Channel)
  end

  def show(conn, params) do
    channel = Repo.get_by(Channel, name: params["id"]) |> Repo.preload(messages: :person)
    render conn, "show.html", channel: channel
  end
end
