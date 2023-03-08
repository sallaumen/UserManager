import Config

config :user_manager,
  ecto_repos: [UserManager.Repo]

# Configures the endpoint
config :user_manager, UserManagerWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: UserManagerWeb.Views.ErrorView],
    layout: false
  ],
  pubsub_server: UserManager.PubSub,
  live_view: [signing_salt: "4H+dwUNP"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
