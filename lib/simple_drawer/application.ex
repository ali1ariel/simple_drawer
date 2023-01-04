defmodule SimpleDrawer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      SimpleDrawer.Repo,
      # Start the Telemetry supervisor
      SimpleDrawerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SimpleDrawer.PubSub},
      # Start the Endpoint (http/https)
      SimpleDrawerWeb.Endpoint
      # Start a worker by calling: SimpleDrawer.Worker.start_link(arg)
      # {SimpleDrawer.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SimpleDrawer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SimpleDrawerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
