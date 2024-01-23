defmodule Hobonichi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HobonichiWeb.Telemetry,
      Hobonichi.Repo,
      {DNSCluster, query: Application.get_env(:hobonichi, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Hobonichi.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Hobonichi.Finch},
      # Start a worker by calling: Hobonichi.Worker.start_link(arg)
      # {Hobonichi.Worker, arg},
      # Start to serve requests, typically the last entry
      HobonichiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hobonichi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HobonichiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
