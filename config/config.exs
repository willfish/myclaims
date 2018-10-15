# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :myclaims,
  ecto_repos: [Myclaims.Repo]

# Configures the endpoint
config :myclaims, MyclaimsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "H+idQtm8QvjLjcoxFwzOsJVCifnSKYeKTPh65Cems0/00ATvCCmj8CZQZ/ZLr7a4",
  render_errors: [view: MyclaimsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Myclaims.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Myclaims.Coherence.User,
  repo: Myclaims.Repo,
  module: Myclaims,
  web_module: MyclaimsWeb,
  router: MyclaimsWeb.Router,
  messages_backend: MyclaimsWeb.Coherence.Messages,
  logged_out_url: "/",
  registration_permitted_attributes: ["email","name","password","current_password","password_confirmation"],
  invitation_permitted_attributes: ["name","email"],
  password_reset_permitted_attributes: ["reset_password_token","password","password_confirmation"],
  session_permitted_attributes: ["remember","email","password"],
  email_from_name: "Your Name",
  email_from_email: "yourname@example.com",
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :invitable, :registerable]

config :coherence, MyclaimsWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%
