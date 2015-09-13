defmodule Logs.Channel do
  use Ecto.Model

  schema "channels" do
    field :name

    has_many :messages, Logs.Message
  end
end
