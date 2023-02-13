defmodule Jodoapp.Repo do
  use Ecto.Repo,
    otp_app: :jodoapp,
    adapter: Ecto.Adapters.Postgres
end
