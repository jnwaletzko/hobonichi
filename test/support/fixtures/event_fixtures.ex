defmodule Hobonichi.EventFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hobonichi.Event` context.
  """

  @doc """
  Generate a birthday.
  """
  def birthday_fixture(attrs \\ %{}) do
    {:ok, birthday} =
      attrs
      |> Enum.into(%{
        date: ~D[2024-01-22],
        name: "some name"
      })
      |> Hobonichi.Event.create_birthday()

    birthday
  end
end
