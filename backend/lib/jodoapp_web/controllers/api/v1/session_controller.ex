defmodule JodoappWeb.API.V1.SessionController do
  use JodoappWeb, :controller

  alias Jodoapp.Accounts

  action_fallback JodoappWeb.FallbackController

  def create(conn, %{"user" => %{"email" => email, "password" => password}=_user_params}=_params) do
    if user = Accounts.get_user_by_email_and_password(email, password) do

      token = Accounts.generate_user_session_token(user)
      json(conn, %{data: %{token: Base.url_encode64(token)}})
    else
      {:error, :unauthenticated}
    end

  end
end
