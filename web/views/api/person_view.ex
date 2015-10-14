defmodule Logs.API.PersonView do
  use Logs.Web, :view

  def render("activity.json", %{activity: activity}) do
    Enum.map(activity, fn([count, {year, month, day}]) ->
      date = Timex.Date.from({year, month, day})
      { :ok, date_str } = Timex.DateFormat.format(date, "%Y-%m-%d", :strftime)
      %{count: count, date: date_str }
    end)
  end
end
