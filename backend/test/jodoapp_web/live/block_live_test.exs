defmodule JodoappWeb.BlockLiveTest do
  use JodoappWeb.ConnCase

  import Phoenix.LiveViewTest
  import Jodoapp.BlocksFixtures

  @create_attrs %{completed_at: %{day: 6, hour: 9, minute: 35, month: 2, year: 2023}, description: "some description", title: "some title", type: 42}
  @update_attrs %{completed_at: %{day: 7, hour: 9, minute: 35, month: 2, year: 2023}, description: "some updated description", title: "some updated title", type: 43}
  @invalid_attrs %{completed_at: %{day: 30, hour: 9, minute: 35, month: 2, year: 2023}, description: nil, title: nil, type: nil}

  defp create_block(_) do
    block = block_fixture()
    %{block: block}
  end

  describe "Index" do
    setup [:create_block]

    test "lists all blocks", %{conn: conn, block: block} do
      {:ok, _index_live, html} = live(conn, Routes.block_index_path(conn, :index))

      assert html =~ "Listing Blocks"
      assert html =~ block.description
    end

    test "saves new block", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.block_index_path(conn, :index))

      assert index_live |> element("a", "New Block") |> render_click() =~
               "New Block"

      assert_patch(index_live, Routes.block_index_path(conn, :new))

      assert index_live
             |> form("#block-form", block: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#block-form", block: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.block_index_path(conn, :index))

      assert html =~ "Block created successfully"
      assert html =~ "some description"
    end

    test "updates block in listing", %{conn: conn, block: block} do
      {:ok, index_live, _html} = live(conn, Routes.block_index_path(conn, :index))

      assert index_live |> element("#block-#{block.id} a", "Edit") |> render_click() =~
               "Edit Block"

      assert_patch(index_live, Routes.block_index_path(conn, :edit, block))

      assert index_live
             |> form("#block-form", block: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#block-form", block: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.block_index_path(conn, :index))

      assert html =~ "Block updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes block in listing", %{conn: conn, block: block} do
      {:ok, index_live, _html} = live(conn, Routes.block_index_path(conn, :index))

      assert index_live |> element("#block-#{block.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#block-#{block.id}")
    end
  end

  describe "Show" do
    setup [:create_block]

    test "displays block", %{conn: conn, block: block} do
      {:ok, _show_live, html} = live(conn, Routes.block_show_path(conn, :show, block))

      assert html =~ "Show Block"
      assert html =~ block.description
    end

    test "updates block within modal", %{conn: conn, block: block} do
      {:ok, show_live, _html} = live(conn, Routes.block_show_path(conn, :show, block))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Block"

      assert_patch(show_live, Routes.block_show_path(conn, :edit, block))

      assert show_live
             |> form("#block-form", block: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#block-form", block: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.block_show_path(conn, :show, block))

      assert html =~ "Block updated successfully"
      assert html =~ "some updated description"
    end
  end
end
