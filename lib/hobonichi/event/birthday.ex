defmodule Hobonichi.Event.Birthday do
  use Ecto.Schema
  import Ecto.Changeset

  schema "birthdays" do
    field :name, :string
    field :date, :date

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(birthday, attrs) do
    birthday
    |> cast(attrs, [:name, :date])
    |> validate_required([:name, :date])
  end
end
