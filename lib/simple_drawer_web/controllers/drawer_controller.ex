defmodule SimpleDrawerWeb.DrawerController do
  use SimpleDrawerWeb, :controller

  alias SimpleDrawer.Drawers
  alias SimpleDrawer.Drawers.Drawer
  alias SimpleDrawer.Drawers.UserDrawer

  action_fallback SimpleDrawerWeb.FallbackController

  # def index(conn, _params) do
  #   drawers = Drawers.list_drawers()
  #   render(conn, "index.json", drawers: drawers)
  # end

  def create(conn, %{"drawer" => drawer_params}) do
    with {:ok, %Drawer{} = drawer} <- Drawers.create_drawer(drawer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.drawer_path(conn, :show, drawer))
      |> render("show.json", drawer: drawer)
    end
  end

  def show(conn, %{"id" => id}) do
    drawer = Drawers.get_drawer!(id)
    render(conn, "show.json", drawer: drawer)
  end

  def show_drawer_info(conn, %{"id" => id}) do

    with {:ok, initial_drawer} <- Drawers.get_drawer_info(id), {:ok, %Drawer{} = drawer} <- has_winner(initial_drawer) do
      render(conn, "show_with_winner.json", drawer: drawer)
    end
  end

  # def update(conn, %{"id" => id, "drawer" => drawer_params}) do
  #   drawer = Drawers.get_drawer!(id)

  #   with {:ok, %Drawer{} = drawer} <- Drawers.update_drawer(drawer, drawer_params) do
  #     render(conn, "show.json", drawer: drawer)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   drawer = Drawers.get_drawer!(id)

  #   with {:ok, %Drawer{}} <- Drawers.delete_drawer(drawer) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end

  def subscribe_user(conn, %{"user_drawer" => user_drawer_params}) do
    with {:ok, %UserDrawer{} = user_drawer} <- Drawers.create_user_drawer(user_drawer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.drawer_path(conn, :show, user_drawer))
      |> render("user_drawer.json", drawer: user_drawer)
    end
  end

  defp has_winner(drawer) do
    case !is_nil(drawer.winner_id) do
      true -> {:ok, drawer}
      false -> {:error, :drawer_not_finished_yet}
    end
  end
end
