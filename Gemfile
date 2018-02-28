source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'redis'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'

group :development, :test do
  # for console and debug
  gem 'hirb'
  gem 'pry-remote'

  # RSpec
  gem 'rspec-rails'
  gem 'shoulda-matchers'

  # Time Mock
  gem 'timecop'

  # mock data for 3rd party API
  gem 'vcr'
  gem 'webmock'

  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'capybara-screenshot'
  gem 'selenium-webdriver'

  # guard
  gem 'guard-livereload'
  gem 'guard-pow'
  gem 'guard-rspec', require: false
  gem 'terminal-notifier-guard'

  # factory bot + faker for test data
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'

  # add schema comments in related files
  gem 'annotate'

  # better error page
  gem 'better_errors'
  gem 'binding_of_caller'

  # support for chrome rails panel
  gem 'meta_request'

  # Linter
  gem 'rubocop', '~> 0.49.0'

  # detect N+1 query
  gem 'bullet'

  # Deploy tools
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-db-tasks', require: false
  gem 'capistrano-rails'
  gem 'capistrano-rbenv', github: 'capistrano/rbenv'
  gem 'capistrano-sidekiq'
  gem 'slackistrano'

  # page proformence monitor
  gem 'rack-mini-profiler', require: false

  # foreman for multi-process management
  gem 'foreman'

  # generator for service objects, form objects, PORO, policy objects.
  gem 'pattern_generator' # FIXIT: we should fork this gem and update form template

  # Documentation
  gem 'github-markup'
  gem 'redcarpet'
  gem 'yard'

  # i18n for js world
  gem 'i18n-js'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# pg adapter
gem 'pg'

# users authenticate
gem 'devise'
gem 'jwt'

# Oauth
gem 'koala', '~> 2.2'
gem 'omniauth'
gem 'omniauth-facebook'

# CORS
gem 'rack-cors', require: 'rack/cors'

# Serializer
gem 'active_model_serializers', '~> 0.10.7'

# paginate
gem 'kaminari'

# odd Tools set
gem 'espresso_martini', github: 'oracle-design/espresso_martini'

# using slim as view template
gem 'slim-rails'

# Debug tools
gem 'awesome_rails_console'

# App settings function
gem 'rails-settings-cached'

# store sensitive settings
gem 'figaro'

# for View components and cache
gem 'cells'
gem 'cells-rails'
gem 'cells-slim'

# for Form Object
gem 'reform'
gem 'reform-rails'

# file upload and image process
gem 'carrierwave'
gem 'mini_magick'

# SEO
gem 'favicon_maker'
gem 'meta-tags'

# job
gem 'sidekiq'

# authorization
gem 'pundit'

# query DB based on time
gem 'by_star'

# aasm state machine
gem 'aasm'

# friendly ID
gem 'friendly_id', '~> 5.1.0'

# breadcrumb
gem 'gretel'

# for eamil
gem 'roadie-rails', '~> 1.0'

# for cron job
gem 'whenever', require: false