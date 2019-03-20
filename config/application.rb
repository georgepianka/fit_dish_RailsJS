require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FitDish
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2


    # Facebook required HTTPS
    #config.force_ssl = true

    # Facebook automatically allows http://localhost REDIRECTS in Development Mode

    # With HTTP, Site URL must be localhost:3000, not 0.0.0.0:3000
    # http://localhost:3000/


    #FACEBOOK LOGIN SETTINGS:

    #Site URL
    #https://localhost:3000/

    #Valid OAuth Redirect URIs
    # https://0.0.0.0:3000/auth/facebook/callback
    # https://localhost:3000/auth/facebook/callback

    # bundle exec thin start --ssl

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    #config.api_only = true
  end
end
