defmodule SimpleDrawer.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias SimpleDrawer.Drawers.UserDrawer

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :name, :string

    has_many :user_drawers, UserDrawer
    has_many :drawers, through: [:user_drawers, :drawer]

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
