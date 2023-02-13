defmodule JodoappWeb.API.V1.BlockController do
  use JodoappWeb, :controller

  alias Jodoapp.Blocks

  action_fallback JodoappWeb.FallbackController

  def index(conn, params) do
    blocks = Blocks.list_blocks(conn.assigns.current_user)
    json(conn, %{data: blocks})
  end

  def create(conn, %{"block" => block_params}=_params) do
    with {:ok, block} <- Blocks.create_block(conn.assigns.current_user, block_params) do
      conn
      |> put_status(:created)
      |> json(%{data: block})
    end
  end

  def update(conn, %{"block" => block_params, "id" => id}) do
    block = Blocks.get_block!(id)

    if block.user_id == conn.assigns.current_user.id do
      with {:ok, block} <- Blocks.update_block(block, block_params) do
        conn
        |> json(%{data: block})
      end

    else
      {:error, :unauthorized}
    end
  end

  def delete(conn, %{"id" => id}) do
    block = Blocks.get_block!(id)

    if block.user_id == conn.assigns.current_user.id do
      Blocks.delete_block(block)
      send_resp(conn, :no_content, "")
    else
      {:error, :unauthorized}
    end
  end
end
