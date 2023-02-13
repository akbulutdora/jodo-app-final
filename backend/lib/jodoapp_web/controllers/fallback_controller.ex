defmodule JodoappWeb.FallbackController do
  use Phoenix.Controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(JodoappWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(403)
    |> put_view(JodoappWeb.ErrorView)
    |> render(:"403")
  end

  def call(conn, {:error, :unauthenticated}) do
    conn
    |> put_status(403)
    |> put_view(JodoappWeb.ErrorView)
    |> render(:"401")
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(JodoappWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end
end
