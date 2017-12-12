source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # for console and debug
  gem 'hirb'
  gem 'hirb-unicode'
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
  gem "binding_of_caller"

  # support for chrome rails panel
  gem 'meta_request'

  # Linter
  gem 'rubocop'

  # detect N+1 query
  gem 'bullet'

  # Deploy tools
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem "capistrano-db-tasks", require: false
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
  gem 'yard'
  gem 'redcarpet'
  gem 'github-markup'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# pg adapter
gem 'pg'

# users authenticate
gem 'devise'

# Oauth
gem 'omniauth'
gem 'omniauth-facebook'
gem 'koala', '~> 2.2'

# CORS
gem 'rack-cors', require: 'rack/cors'

# Serializer
gem 'active_model_serializers', '~> 0.10.7'

# odd Tools set
gem 'espresso_martini', github: 'oracle-design/espresso_martini'

# using slim as view template
gem 'slim-rails'

# Debug tools
gem 'awesome_rails_console'

# notifications
gem 'growlyflash'
gem 'sweet-alert2-rails'

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
