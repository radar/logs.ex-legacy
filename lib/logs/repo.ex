defmodule Logs.Repo do
  use Ecto.Repo, otp_app: :logs
  use Scrivener, page_size: 20
end
