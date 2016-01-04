defmodule Logs.ChannelView do
  use Logs.Web, :view

  def pretty_date(date) do
    date |> Calendar.Strftime.strftime!("%Y-%m-%d")
  end
end
