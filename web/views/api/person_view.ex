defmodule Logs.API.PersonView do
  use Logs.Web, :view

  def render("activity.json", %{activity: activity}) do
    Enum.map(activity, fn([count, {year, month, day}]) ->
      date_str = {year, month, day} |> Calendar.Date.Format.iso8601
      %{count: count, date: date_str }
    end)
  end
end
