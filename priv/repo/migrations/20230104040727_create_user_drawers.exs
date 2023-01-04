defmodule SimpleDrawer.Repo.Migrations.CreateUserDrawers do
  use Ecto.Migration

  def change do
    create table(:user_drawers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :drawer_id, references(:drawers, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:user_drawers, [:user_id])
    create index(:user_drawers, [:drawer_id])

    create unique_index(:user_drawers, [:user_id, :drawer_id], name: :index_for_user_duplicate_in_drawer_entries)
  end
end
