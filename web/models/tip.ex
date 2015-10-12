defmodule Logs.Tip do
  use Ecto.Model

  schema "tips" do
    field :command
    field :text
  end
end
