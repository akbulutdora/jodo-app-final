defmodule JodoappWeb.API.V1.RegistrationController do
  use JodoappWeb, :controller

  alias Jodoapp.Accounts

  action_fallback JodoappWeb.FallbackController

  def create(conn, %{"user" => user_params}=_params) do
    with {:ok, user} <- Accounts.register_user(user_params) do
      conn
      |> put_status(:created)
      |> json(%{data: %{user: user}})
    end

  end
end
