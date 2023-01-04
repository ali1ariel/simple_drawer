defmodule SimpleDrawer.Repo.Migrations.AddWinnerToDrawers do
  use Ecto.Migration

  def change do
    alter table(:drawers) do
      add :winner_id, references(:users, on_delete: :nothing, type: :binary_id)
    end

  end
end
