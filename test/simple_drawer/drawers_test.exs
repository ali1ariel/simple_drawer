defmodule SimpleDrawer.DrawersTest do
  use SimpleDrawer.DataCase

  alias SimpleDrawer.Drawers

  describe "drawers" do
    alias SimpleDrawer.Drawers.Drawer

    import SimpleDrawer.DrawersFixtures

    @invalid_attrs %{drawer_date: nil, name: nil}

    test "list_drawers/0 returns all drawers" do
      drawer = drawer_fixture()
      assert Drawers.list_drawers() == [drawer]
    end

    test "get_drawer!/1 returns the drawer with given id" do
      drawer = drawer_fixture()
      assert Drawers.get_drawer!(drawer.id) == drawer
    end

    test "create_drawer/1 with valid data creates a drawer" do
      valid_attrs = %{drawer_date: ~N[2023-01-03 03:25:00], name: "some name"}

      assert {:ok, %Drawer{} = drawer} = Drawers.create_drawer(valid_attrs)
      assert drawer.drawer_date == ~N[2023-01-03 03:25:00]
      assert drawer.name == "some name"
    end

    test "create_drawer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drawers.create_drawer(@invalid_attrs)
    end

    test "update_drawer/2 with valid data updates the drawer" do
      drawer = drawer_fixture()
      update_attrs = %{drawer_date: ~N[2023-01-04 03:25:00], name: "some updated name"}

      assert {:ok, %Drawer{} = drawer} = Drawers.update_drawer(drawer, update_attrs)
      assert drawer.drawer_date == ~N[2023-01-04 03:25:00]
      assert drawer.name == "some updated name"
    end

    test "update_drawer/2 with invalid data returns error changeset" do
      drawer = drawer_fixture()
      assert {:error, %Ecto.Changeset{}} = Drawers.update_drawer(drawer, @invalid_attrs)
      assert drawer == Drawers.get_drawer!(drawer.id)
    end

    test "delete_drawer/1 deletes the drawer" do
      drawer = drawer_fixture()
      assert {:ok, %Drawer{}} = Drawers.delete_drawer(drawer)
      assert_raise Ecto.NoResultsError, fn -> Drawers.get_drawer!(drawer.id) end
    end

    test "change_drawer/1 returns a drawer changeset" do
      drawer = drawer_fixture()
      assert %Ecto.Changeset{} = Drawers.change_drawer(drawer)
    end
  end

  describe "user_drawers" do
    alias SimpleDrawer.Drawers.UserDrawer

    import SimpleDrawer.DrawersFixtures

    @invalid_attrs %{}

    test "list_user_drawers/0 returns all user_drawers" do
      user_drawer = user_drawer_fixture()
      assert Drawers.list_user_drawers() == [user_drawer]
    end

    test "get_user_drawer!/1 returns the user_drawer with given id" do
      user_drawer = user_drawer_fixture()
      assert Drawers.get_user_drawer!(user_drawer.id) == user_drawer
    end

    test "create_user_drawer/1 with valid data creates a user_drawer" do
      valid_attrs = %{}

      assert {:ok, %UserDrawer{} = user_drawer} = Drawers.create_user_drawer(valid_attrs)
    end

    test "create_user_drawer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drawers.create_user_drawer(@invalid_attrs)
    end

    test "update_user_drawer/2 with valid data updates the user_drawer" do
      user_drawer = user_drawer_fixture()
      update_attrs = %{}

      assert {:ok, %UserDrawer{} = user_drawer} = Drawers.update_user_drawer(user_drawer, update_attrs)
    end

    test "update_user_drawer/2 with invalid data returns error changeset" do
      user_drawer = user_drawer_fixture()
      assert {:error, %Ecto.Changeset{}} = Drawers.update_user_drawer(user_drawer, @invalid_attrs)
      assert user_drawer == Drawers.get_user_drawer!(user_drawer.id)
    end

    test "delete_user_drawer/1 deletes the user_drawer" do
      user_drawer = user_drawer_fixture()
      assert {:ok, %UserDrawer{}} = Drawers.delete_user_drawer(user_drawer)
      assert_raise Ecto.NoResultsError, fn -> Drawers.get_user_drawer!(user_drawer.id) end
    end

    test "change_user_drawer/1 returns a user_drawer changeset" do
      user_drawer = user_drawer_fixture()
      assert %Ecto.Changeset{} = Drawers.change_user_drawer(user_drawer)
    end
  end
end
