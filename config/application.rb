require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# TODO: change module name as your project name instead of `AppStarter`
module AppStarter
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Set timezone
    config.time_zone = 'Taipei'
    config.active_record.default_timezone = :local

    # Set locale
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = "zh-TW"
    config.i18n.available_locales = [:"zh-TW", :en]
    config.i18n.fallbacks = [:en]

    # Set generator
    config.generators do |g|
      g.orm :active_record
      g.view_specs false
      g.routing_specs false
      g.helper_specs false
      g.request_specs false
      g.assets false
      g.helper false
    end

    # ActiveJob
    config.active_job.queue_adapter = :sidekiq
  end
end
