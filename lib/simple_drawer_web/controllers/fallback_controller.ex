defmodule SimpleDrawerWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use SimpleDrawerWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(SimpleDrawerWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(SimpleDrawerWeb.ErrorView)
    |> render(:"404")
  end
  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :drawer_not_found}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(SimpleDrawerWeb.ErrorView)
    |> render("error_drawer_not_found.json", %{})
  end
  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :drawer_not_finished_yet}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(SimpleDrawerWeb.ErrorView)
    |> render("error_drawer_not_finished_yet.json", %{})
  end
end
