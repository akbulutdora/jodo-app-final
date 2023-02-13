defmodule Jodoapp.BlocksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Jodoapp.Blocks` context.
  """

  @doc """
  Generate a block.
  """
  def block_fixture(attrs \\ %{}) do
    {:ok, block} =
      attrs
      |> Enum.into(%{
        completed_at: ~U[2023-02-06 09:35:00.000000Z],
        description: "some description",
        title: "some title",
        type: 42
      })
      |> Jodoapp.Blocks.create_block()

    block
  end
end
