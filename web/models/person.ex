defmodule Logs.Person do
  use Ecto.Schema

  schema "people" do
    field :nick

    has_many :messages, Logs.Message
  end

end
