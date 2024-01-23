defmodule HobonichiWeb.BirthdayLive.Index do
  use HobonichiWeb, :live_view

  alias Hobonichi.Event
  alias Hobonichi.Event.Birthday

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :birthdays, Event.list_birthdays())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Birthday")
    |> assign(:birthday, Event.get_birthday!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Birthday")
    |> assign(:birthday, %Birthday{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Birthdays")
    |> assign(:birthday, nil)
  end

  @impl true
  def handle_info({HobonichiWeb.BirthdayLive.FormComponent, {:saved, birthday}}, socket) do
    {:noreply, stream_insert(socket, :birthdays, birthday)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    birthday = Event.get_birthday!(id)
    {:ok, _} = Event.delete_birthday(birthday)

    {:noreply, stream_delete(socket, :birthdays, birthday)}
  end
end
