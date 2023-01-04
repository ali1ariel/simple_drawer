defmodule SimpleDrawer.Drawers.Drawer do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoCommons.DateTimeValidator

  alias SimpleDrawer.Drawers.UserDrawer
  alias SimpleDrawer.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "drawers" do
    field :drawer_date, :utc_datetime
    field :name, :string

    has_many :users_drawer, UserDrawer
    has_many :users, through: [:users_drawer, :user]

    belongs_to :winner, User, foreign_key: :winner_id

    timestamps()
  end

  @doc false
  def changeset(drawer, attrs) do
    drawer
    |> cast(attrs, [:name, :drawer_date])
    |> validate_required([:name, :drawer_date])
    |> validate_datetime(:drawer_date, after: :utc_now)
  end

  def winner_changeset(drawer, attrs) do
    drawer
    |> cast(attrs, [:winner_id])
    |> cast_assoc(:winner)
  end
end
