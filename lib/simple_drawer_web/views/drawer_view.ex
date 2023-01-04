defmodule SimpleDrawerWeb.DrawerView do
  use SimpleDrawerWeb, :view
  alias SimpleDrawerWeb.DrawerView

  def render("index.json", %{drawers: drawers}) do
    %{data: render_many(drawers, DrawerView, "drawer.json")}
  end

  def render("show.json", %{drawer: drawer}) do
    %{data: render_one(drawer, DrawerView, "drawer.json")}
  end

  def render("show_with_winner.json", %{drawer: drawer}) do
    %{data: render_one(drawer, DrawerView, "drawer_with_winner.json")}
  end

  def render("drawer.json", %{drawer: drawer}) do
    %{
      id: drawer.id,
      name: drawer.name,
      drawer_date: drawer.drawer_date
    }
  end

  def render("drawer_with_winner.json", %{drawer: drawer}) do
    %{
      id: drawer.id,
      name: drawer.name,
      winner_id: drawer.winner.id,
      winner_name: drawer.winner.name,
      winner_email: drawer.winner.email,
      drawer_date: drawer.drawer_date
    }
  end

  def render("user_drawer.json", _) do
    %{
      data: :ok
    }
  end
end
