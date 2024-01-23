defmodule Hobonichi.EventTest do
  use Hobonichi.DataCase

  alias Hobonichi.Event

  describe "birthdays" do
    alias Hobonichi.Event.Birthday

    import Hobonichi.EventFixtures

    @invalid_attrs %{name: nil, date: nil}

    test "list_birthdays/0 returns all birthdays" do
      birthday = birthday_fixture()
      assert Event.list_birthdays() == [birthday]
    end

    test "get_birthday!/1 returns the birthday with given id" do
      birthday = birthday_fixture()
      assert Event.get_birthday!(birthday.id) == birthday
    end

    test "create_birthday/1 with valid data creates a birthday" do
      valid_attrs = %{name: "some name", date: ~D[2024-01-22]}

      assert {:ok, %Birthday{} = birthday} = Event.create_birthday(valid_attrs)
      assert birthday.name == "some name"
      assert birthday.date == ~D[2024-01-22]
    end

    test "create_birthday/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Event.create_birthday(@invalid_attrs)
    end

    test "update_birthday/2 with valid data updates the birthday" do
      birthday = birthday_fixture()
      update_attrs = %{name: "some updated name", date: ~D[2024-01-23]}

      assert {:ok, %Birthday{} = birthday} = Event.update_birthday(birthday, update_attrs)
      assert birthday.name == "some updated name"
      assert birthday.date == ~D[2024-01-23]
    end

    test "update_birthday/2 with invalid data returns error changeset" do
      birthday = birthday_fixture()
      assert {:error, %Ecto.Changeset{}} = Event.update_birthday(birthday, @invalid_attrs)
      assert birthday == Event.get_birthday!(birthday.id)
    end

    test "delete_birthday/1 deletes the birthday" do
      birthday = birthday_fixture()
      assert {:ok, %Birthday{}} = Event.delete_birthday(birthday)
      assert_raise Ecto.NoResultsError, fn -> Event.get_birthday!(birthday.id) end
    end

    test "change_birthday/1 returns a birthday changeset" do
      birthday = birthday_fixture()
      assert %Ecto.Changeset{} = Event.change_birthday(birthday)
    end
  end
end
