defmodule SimpleDrawerWeb.DrawerControllerTest do
  use SimpleDrawerWeb.ConnCase

  import SimpleDrawer.DrawersFixtures

  alias SimpleDrawer.Drawers.Drawer

  @create_attrs %{
    drawer_date: ~N[2023-01-03 03:25:00],
    name: "some name"
  }
  @update_attrs %{
    drawer_date: ~N[2023-01-04 03:25:00],
    name: "some updated name"
  }
  @invalid_attrs %{drawer_date: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all drawers", %{conn: conn} do
      conn = get(conn, Routes.drawer_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create drawer" do
    test "renders drawer when data is valid", %{conn: conn} do
      conn = post(conn, Routes.drawer_path(conn, :create), drawer: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.drawer_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "drawer_date" => "2023-01-03T03:25:00",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.drawer_path(conn, :create), drawer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update drawer" do
    setup [:create_drawer]

    test "renders drawer when data is valid", %{conn: conn, drawer: %Drawer{id: id} = drawer} do
      conn = put(conn, Routes.drawer_path(conn, :update, drawer), drawer: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.drawer_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "drawer_date" => "2023-01-04T03:25:00",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, drawer: drawer} do
      conn = put(conn, Routes.drawer_path(conn, :update, drawer), drawer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete drawer" do
    setup [:create_drawer]

    test "deletes chosen drawer", %{conn: conn, drawer: drawer} do
      conn = delete(conn, Routes.drawer_path(conn, :delete, drawer))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.drawer_path(conn, :show, drawer))
      end
    end
  end

  defp create_drawer(_) do
    drawer = drawer_fixture()
    %{drawer: drawer}
  end
end
