# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :chronos, Chronos.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "Dl+AILkdrysSgk14i5539J7Xpn5EMlptuzs2+7eDbL97Ucq0dcP+0FCDnsENh+eA",
  render_errors: [default_format: "html"],
  pubsub: [name: Chronos.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Start with selenium driver (default)
config :hound, driver: "selenium"
#config :hound, browser: "chrome" # Use Chrome with the default driver (selenium)
#config :hound, port: 1234, browser: "firefox" # Start with default driver at port 1234 and use firefox
#config :hound, driver: "phantomjs" # Start Hound for PhantomJs
#config :hound, driver: "chrome_driver" # Start Hound for ChromeDriver (default port 9515 assumed)
#config :hound, driver: "phantomjs", host: "http://example.com", port: 5555 # Start Hound for remote PhantomJs server at port 5555
#config :hound, app_host: "http://localhost", app_port: 4000 # Define your application's host and port (defaults to "http://localhost:4000")