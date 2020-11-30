defmodule SurfaceDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      SurfaceDemo.Repo,
      # Start the Telemetry supervisor
      SurfaceDemoWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SurfaceDemo.PubSub},
      # Start the Endpoint (http/https)
      SurfaceDemoWeb.Endpoint
      # Start a worker by calling: SurfaceDemo.Worker.start_link(arg)
      # {SurfaceDemo.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SurfaceDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SurfaceDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
