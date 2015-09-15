defmodule Logs.Channel do
  use Ecto.Model

  schema "channels" do
    field :name
    field :hidden, :boolean, default: false

    has_many :messages, Logs.Message
  end
end
