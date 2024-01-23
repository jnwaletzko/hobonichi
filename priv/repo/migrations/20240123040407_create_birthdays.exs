defmodule Hobonichi.Repo.Migrations.CreateBirthdays do
  use Ecto.Migration

  def change do
    create table(:birthdays) do
      add :name, :string
      add :date, :date

      timestamps(type: :utc_datetime)
    end
  end
end
