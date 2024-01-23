defmodule HobonichiWeb.BirthdayLiveTest do
  use HobonichiWeb.ConnCase

  import Phoenix.LiveViewTest
  import Hobonichi.EventFixtures

  @create_attrs %{name: "some name", date: "2024-01-22"}
  @update_attrs %{name: "some updated name", date: "2024-01-23"}
  @invalid_attrs %{name: nil, date: nil}

  defp create_birthday(_) do
    birthday = birthday_fixture()
    %{birthday: birthday}
  end

  describe "Index" do
    setup [:create_birthday]

    test "lists all birthdays", %{conn: conn, birthday: birthday} do
      {:ok, _index_live, html} = live(conn, ~p"/birthdays")

      assert html =~ "Listing Birthdays"
      assert html =~ birthday.name
    end

    test "saves new birthday", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/birthdays")

      assert index_live |> element("a", "New Birthday") |> render_click() =~
               "New Birthday"

      assert_patch(index_live, ~p"/birthdays/new")

      assert index_live
             |> form("#birthday-form", birthday: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#birthday-form", birthday: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/birthdays")

      html = render(index_live)
      assert html =~ "Birthday created successfully"
      assert html =~ "some name"
    end

    test "updates birthday in listing", %{conn: conn, birthday: birthday} do
      {:ok, index_live, _html} = live(conn, ~p"/birthdays")

      assert index_live |> element("#birthdays-#{birthday.id} a", "Edit") |> render_click() =~
               "Edit Birthday"

      assert_patch(index_live, ~p"/birthdays/#{birthday}/edit")

      assert index_live
             |> form("#birthday-form", birthday: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#birthday-form", birthday: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/birthdays")

      html = render(index_live)
      assert html =~ "Birthday updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes birthday in listing", %{conn: conn, birthday: birthday} do
      {:ok, index_live, _html} = live(conn, ~p"/birthdays")

      assert index_live |> element("#birthdays-#{birthday.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#birthdays-#{birthday.id}")
    end
  end

  describe "Show" do
    setup [:create_birthday]

    test "displays birthday", %{conn: conn, birthday: birthday} do
      {:ok, _show_live, html} = live(conn, ~p"/birthdays/#{birthday}")

      assert html =~ "Show Birthday"
      assert html =~ birthday.name
    end

    test "updates birthday within modal", %{conn: conn, birthday: birthday} do
      {:ok, show_live, _html} = live(conn, ~p"/birthdays/#{birthday}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Birthday"

      assert_patch(show_live, ~p"/birthdays/#{birthday}/show/edit")

      assert show_live
             |> form("#birthday-form", birthday: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#birthday-form", birthday: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/birthdays/#{birthday}")

      html = render(show_live)
      assert html =~ "Birthday updated successfully"
      assert html =~ "some updated name"
    end
  end
end
