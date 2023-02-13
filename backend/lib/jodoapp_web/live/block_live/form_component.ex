defmodule JodoappWeb.BlockLive.FormComponent do
  use JodoappWeb, :live_component

  alias Jodoapp.Blocks

  @impl true
  def update(%{block: block} = assigns, socket) do
    changeset = Blocks.change_block(block)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"block" => block_params}, socket) do
    changeset =
      socket.assigns.block
      |> Blocks.change_block(block_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"block" => block_params}, socket) do
    save_block(socket, socket.assigns.action, block_params)
  end

  defp save_block(socket, :edit, block_params) do
    case Blocks.update_block(socket.assigns.block, block_params) do
      {:ok, _block} ->
        {:noreply,
         socket
         |> put_flash(:info, "Block updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_block(socket, :new, block_params) do
    case Blocks.create_block(block_params) do
      {:ok, _block} ->
        {:noreply,
         socket
         |> put_flash(:info, "Block created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
