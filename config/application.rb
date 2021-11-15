require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OsuTourney
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    Rails.application.config.middleware.insert_before 0, Rack::Cors do
      allow do
        if Rails.env.development?
          origins 'localhost:3000', 'localhost:3001', 'https://osu.ppy.sh/community/matches/89309929'
        else
          origins 'https://osu.ppy.sh/community/matches/89309929'
        end
    
        resource '*',
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
