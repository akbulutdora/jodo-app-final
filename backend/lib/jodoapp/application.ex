defmodule Jodoapp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Jodoapp.Repo,
      # Start the Telemetry supervisor
      JodoappWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Jodoapp.PubSub},
      # Start the Endpoint (http/https)
      JodoappWeb.Endpoint
      # Start a worker by calling: Jodoapp.Worker.start_link(arg)
      # {Jodoapp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Jodoapp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JodoappWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
