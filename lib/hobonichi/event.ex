defmodule Hobonichi.Event do
  @moduledoc """
  The Event context.
  """

  import Ecto.Query, warn: false
  alias Hobonichi.Repo

  alias Hobonichi.Event.Birthday

  @doc """
  Returns the list of birthdays.

  ## Examples

      iex> list_birthdays()
      [%Birthday{}, ...]

  """
  def list_birthdays do
    Repo.all(Birthday)
  end

  @doc """
  Gets a single birthday.

  Raises `Ecto.NoResultsError` if the Birthday does not exist.

  ## Examples

      iex> get_birthday!(123)
      %Birthday{}

      iex> get_birthday!(456)
      ** (Ecto.NoResultsError)

  """
  def get_birthday!(id), do: Repo.get!(Birthday, id)

  @doc """
  Creates a birthday.

  ## Examples

      iex> create_birthday(%{field: value})
      {:ok, %Birthday{}}

      iex> create_birthday(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_birthday(attrs \\ %{}) do
    %Birthday{}
    |> Birthday.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a birthday.

  ## Examples

      iex> update_birthday(birthday, %{field: new_value})
      {:ok, %Birthday{}}

      iex> update_birthday(birthday, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_birthday(%Birthday{} = birthday, attrs) do
    birthday
    |> Birthday.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a birthday.

  ## Examples

      iex> delete_birthday(birthday)
      {:ok, %Birthday{}}

      iex> delete_birthday(birthday)
      {:error, %Ecto.Changeset{}}

  """
  def delete_birthday(%Birthday{} = birthday) do
    Repo.delete(birthday)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking birthday changes.

  ## Examples

      iex> change_birthday(birthday)
      %Ecto.Changeset{data: %Birthday{}}

  """
  def change_birthday(%Birthday{} = birthday, attrs \\ %{}) do
    Birthday.changeset(birthday, attrs)
  end
end
