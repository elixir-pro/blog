# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :blog,
  ecto_repos: [Blog.Repo]

# Configures the endpoint
config :blog, BlogWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZWyl/4JLPWn0jFw0YxeBF8X07W8RbwqKadBVbYmbo3/bq+dX51q01VVXJ3YnkYlG",
  render_errors: [view: BlogWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Blog.PubSub,
  live_view: [signing_salt: "1KY7RegA"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :blog, BlogWeb.Auth.Guardian,
  issuer: "blog",
  secret_key: "cBqHVkspQ8QEej6LbDYu4aW8tF8xoEouLdGPsjaA822l/Hf1mmHFhV//82s64845"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
