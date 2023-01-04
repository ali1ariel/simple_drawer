defmodule SimpleDrawer.Drawers.UserDrawer do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoCommons.DateTimeValidator

  alias SimpleDrawer.Drawers.Drawer
  alias SimpleDrawer.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "user_drawers" do
    field :now, :utc_datetime, virtual: true

    belongs_to :user, User, foreign_key: :user_id
    belongs_to :drawer, Drawer, foreign_key: :drawer_id

    timestamps()
  end

  @doc false
  def changeset(user_drawer, attrs) do
    attrs
    user_drawer
    |> cast(attrs, [:user_id, :drawer_id, :now])
    |> cast_assoc(:user)
    |> cast_assoc(:drawer)
    |> unique_constraint(:title, name: :index_for_user_duplicate_in_drawer_entries)
    |> validate_datetime(:now, before: attrs["drawer_date"])
  end

end
