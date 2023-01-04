defmodule SimpleDrawer.Repo do
  use Ecto.Repo,
    otp_app: :simple_drawer,
    adapter: Ecto.Adapters.Postgres
end
