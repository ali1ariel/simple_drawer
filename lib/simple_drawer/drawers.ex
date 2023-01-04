defmodule SimpleDrawer.Drawers do
  @moduledoc """
  The Drawers context.
  """

  import Ecto.Query, warn: false
  alias SimpleDrawer.Repo

  alias SimpleDrawer.Drawers.Drawer

  @doc """
  Returns the list of drawers.

  ## Examples

      iex> list_drawers()
      [%Drawer{}, ...]

  """
  def list_drawers do
    Repo.all(Drawer)
  end

  @doc """
  Gets a single drawer.

  Raises `Ecto.NoResultsError` if the Drawer does not exist.

  ## Examples

      iex> get_drawer!(123)
      %Drawer{}

      iex> get_drawer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_drawer!(id), do: Repo.get!(Drawer, id)

  @doc """
    Get the informations about the drawer and returns with the
  """
  def get_drawer_info(id) do
    case Repo.get(Drawer, id) do
      %Drawer{} = drawer ->
        {:ok, drawer
        |> Repo.preload([:winner])}
      nil ->
        {:error, :drawer_not_found}
    end
  end

  @doc """
  Creates a drawer.

  ## Examples

      iex> create_drawer(%{field: value})
      {:ok, %Drawer{}}

      iex> create_drawer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_drawer(attrs \\ %{}) do
    %Drawer{}
    |> Drawer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a drawer.

  ## Examples

      iex> update_drawer(drawer, %{field: new_value})
      {:ok, %Drawer{}}

      iex> update_drawer(drawer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_drawer(%Drawer{} = drawer, attrs) do
    drawer
    |> Drawer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a drawer.

  ## Examples

      iex> delete_drawer(drawer)
      {:ok, %Drawer{}}

      iex> delete_drawer(drawer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_drawer(%Drawer{} = drawer) do
    Repo.delete(drawer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking drawer changes.

  ## Examples

      iex> change_drawer(drawer)
      %Ecto.Changeset{data: %Drawer{}}

  """
  def change_drawer(%Drawer{} = drawer, attrs \\ %{}) do
    Drawer.changeset(drawer, attrs)
  end

  alias SimpleDrawer.Drawers.UserDrawer

  @doc """
  Returns the list of user_drawers.

  ## Examples

      iex> list_user_drawers()
      [%UserDrawer{}, ...]

  """
  def list_user_drawers do
    Repo.all(UserDrawer)
  end

  def list_users_by_drawer_id(drawer_id) do
    from(d in Drawer,
      where: d.id == ^drawer_id,
      preload: [:users]
    )
    |> Repo.one()
    |> then(& &1.users)
  end

  @doc """
  Gets a single user_drawer.

  Raises `Ecto.NoResultsError` if the User drawer does not exist.

  ## Examples

      iex> get_user_drawer!(123)
      %UserDrawer{}

      iex> get_user_drawer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_drawer!(id), do: Repo.get!(UserDrawer, id)

  @doc """
  Creates a user_drawer.

  ## Examples

      iex> create_user_drawer(%{field: value})
      {:ok, %UserDrawer{}}

      iex> create_user_drawer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_drawer(%{"drawer_id" => drawer_id} = attrs \\ %{}) do
    drawer =
      get_drawer!(drawer_id)

    extra_validators = %{
      "drawer_date" => drawer.drawer_date,
      "now" => DateTime.utc_now()
    }

    %UserDrawer{}
    |> UserDrawer.changeset(Map.merge(attrs, extra_validators))
    |> Repo.insert()
  end

  @doc """
  Updates a user_drawer.

  ## Examples

      iex> update_user_drawer(user_drawer, %{field: new_value})
      {:ok, %UserDrawer{}}

      iex> update_user_drawer(user_drawer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_drawer(%UserDrawer{} = user_drawer, attrs) do
    user_drawer
    |> UserDrawer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_drawer.

  ## Examples

      iex> delete_user_drawer(user_drawer)
      {:ok, %UserDrawer{}}

      iex> delete_user_drawer(user_drawer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_drawer(%UserDrawer{} = user_drawer) do
    Repo.delete(user_drawer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_drawer changes.

  ## Examples

      iex> change_user_drawer(user_drawer)
      %Ecto.Changeset{data: %UserDrawer{}}

  """
  def change_user_drawer(%UserDrawer{} = user_drawer, attrs \\ %{}) do
    UserDrawer.changeset(user_drawer, attrs)
  end

  @doc """
  Do the draw, getting a random user, and setting as a winner in the Drawer changeset.
  """
  def draw(drawer_id) do
    %{user_id: user_id} = choose_winner(drawer_id)

    get_drawer!(drawer_id)
    |> Drawer.winner_changeset(%{winner_id: user_id})
    |> Repo.update!()
  end

  defp choose_winner(drawer_id) do
    from(u_d in UserDrawer,
      where: u_d.drawer_id == ^drawer_id,
      order_by: fragment("RANDOM()"),
      preload: [:user]
    )
    |> Repo.one()
  end
end
