defmodule Logs.Tip do
  use Ecto.Schema

  schema "tips" do
    field :command
    field :text
  end
end
