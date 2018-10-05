require_relative 'boot'

require 'rails/all'

require 'omniauth'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NuxeoOauth2

  class Application < Rails::Application

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Required by Omniauth
    #config.middleware.use ActionDispatch::Session::CookieStore, config.session_options

    # Load the Omniauth yaml
    config.omniauth = config_for(:omniauth).deep_symbolize_keys

    # Register the Nuxeo Omniauth provider
    if config.omniauth[:providers].present?
      nuxeo_config = config.omniauth[:providers].fetch(:nuxeo, {})

      config.middleware.use OmniAuth::Builder do
        provider :nuxeo, site: nuxeo_config[:site],
                       client_id: nuxeo_config[:client_id],
                       client_secret: nuxeo_config[:client_secret]
      end

      OmniauthNuxeo.logger = Rails.logger
    end

  end

end
