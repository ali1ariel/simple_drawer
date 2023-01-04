defmodule SimpleDrawer.Repo.Migrations.CreateDrawers do
  use Ecto.Migration

  def change do
    create table(:drawers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :drawer_date, :utc_datetime

      timestamps()
    end
  end
end
