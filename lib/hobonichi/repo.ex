defmodule Hobonichi.Repo do
  use Ecto.Repo,
    otp_app: :hobonichi,
    adapter: Ecto.Adapters.Postgres
end
