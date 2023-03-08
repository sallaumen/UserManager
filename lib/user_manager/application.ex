defmodule UserManager.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      UserManagerWeb.Telemetry,
      UserManager.Repo,
      {Phoenix.PubSub, name: UserManager.PubSub},
      UserManagerWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: UserManager.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    UserManagerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
