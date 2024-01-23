defmodule HobonichiWeb.BirthdayLive.FormComponent do
  use HobonichiWeb, :live_component

  alias Hobonichi.Event

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage birthday records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="birthday-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:date]} type="date" label="Date" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Birthday</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{birthday: birthday} = assigns, socket) do
    changeset = Event.change_birthday(birthday)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"birthday" => birthday_params}, socket) do
    changeset =
      socket.assigns.birthday
      |> Event.change_birthday(birthday_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"birthday" => birthday_params}, socket) do
    save_birthday(socket, socket.assigns.action, birthday_params)
  end

  defp save_birthday(socket, :edit, birthday_params) do
    case Event.update_birthday(socket.assigns.birthday, birthday_params) do
      {:ok, birthday} ->
        notify_parent({:saved, birthday})

        {:noreply,
         socket
         |> put_flash(:info, "Birthday updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_birthday(socket, :new, birthday_params) do
    case Event.create_birthday(birthday_params) do
      {:ok, birthday} ->
        notify_parent({:saved, birthday})

        {:noreply,
         socket
         |> put_flash(:info, "Birthday created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
