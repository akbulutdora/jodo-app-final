defmodule JodoappWeb.PageController do
  use JodoappWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
