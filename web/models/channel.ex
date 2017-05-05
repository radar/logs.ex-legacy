defmodule Logs.Channel do
  alias Logs.Channel
  alias Logs.Repo

  import Ecto.Query
  use Ecto.Schema

  schema "channels" do
    field :name
    field :hidden, :boolean, default: false

    has_many :messages, Logs.Message
  end

  def visible_channels do
    visible() |> Repo.all
  end

  def by_name(name) do
    visible() |> Repo.get_by(name: name)
  end

  defp visible do
    Channel |> where(hidden: false)
  end
end
