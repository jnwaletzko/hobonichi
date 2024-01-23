defmodule HobonichiWeb.BirthdayLive.Show do
  use HobonichiWeb, :live_view

  alias Hobonichi.Event

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:birthday, Event.get_birthday!(id))}
  end

  defp page_title(:show), do: "Show Birthday"
  defp page_title(:edit), do: "Edit Birthday"
end
