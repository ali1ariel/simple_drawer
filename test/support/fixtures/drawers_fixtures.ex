defmodule SimpleDrawer.DrawersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SimpleDrawer.Drawers` context.
  """

  @doc """
  Generate a drawer.
  """
  def drawer_fixture(attrs \\ %{}) do
    {:ok, drawer} =
      attrs
      |> Enum.into(%{
        drawer_date: ~N[2023-01-03 03:25:00],
        name: "some name"
      })
      |> SimpleDrawer.Drawers.create_drawer()

    drawer
  end

  @doc """
  Generate a user_drawer.
  """
  def user_drawer_fixture(attrs \\ %{}) do
    {:ok, user_drawer} =
      attrs
      |> Enum.into(%{

      })
      |> SimpleDrawer.Drawers.create_user_drawer()

    user_drawer
  end
end
