defmodule JodoappWeb.BlockLive.Show do
  use JodoappWeb, :live_view

  alias Jodoapp.Blocks

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:block, Blocks.get_block!(id))}
  end

  defp page_title(:show), do: "Show Block"
  defp page_title(:edit), do: "Edit Block"
end
