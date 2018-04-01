source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.6'
gem 'redis'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'

group :development, :test do
  # for console and debug
  gem 'hirb'
  gem 'pry-remote'

  # Test
  gem 'capybara', '~> 2.13' # Adds support for Capybara system testing and selenium driver
  gem 'capybara-screenshot'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false, group: :test
  gem 'timecop' # Time Mock
  gem 'vcr' # mock data for 3rd party API
  gem 'webmock'

  # guard
  gem 'guard-livereload'
  gem 'guard-pow'
  gem 'guard-rspec', require: false
  gem 'terminal-notifier-guard'
end

group :development do
  # Development tools
  gem 'annotate' # add schema comments in related files
  gem 'better_errors' # better error page
  gem 'binding_of_caller' # better errors need this gem
  gem 'bullet' # detect N+1 query
  gem 'debase' # for vscode remote debug
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pattern_generator' # generator for service objects, form objects, PORO, policy objects.
  gem 'rack-mini-profiler', require: false # page proformence monitor
  gem 'rubocop', '~> 0.49.0' # Linter
  gem 'ruby-debug-ide' # for vscode remote debug
  gem 'web-console', '>= 3.3.0'

  # Deploy tools
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-db-tasks', require: false
  gem 'capistrano-rails'
  gem 'capistrano-rbenv', github: 'capistrano/rbenv'
  gem 'capistrano-sidekiq'
  gem 'slackistrano'

  # Documentation
  gem 'github-markup'
  gem 'i18n-js' # i18n for js world
  gem 'redcarpet'
  gem 'yard'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Development tools
gem 'awesome_rails_console' # Debug tools
gem 'espresso_martini', github: 'oracle-design/espresso_martini'

# So backend tools
gem 'carrierwave' # file upload
gem 'figaro' # enviroment variables
gem 'mini_magick' # image process
gem 'sidekiq' # job
gem 'whenever', require: false # for cron job

# Database
gem 'aasm' # aasm state machine
gem 'by_star' # query DB based on time
gem 'friendly_id', '~> 5.1.0' # friendly ID
gem 'money-rails', '~>1' # for currency management
gem 'pg' # postgresSQL adapter
gem 'rails-settings-cached' # App settings function
gem 'ransack' # for meta search

# Authentication
gem 'devise' # users authenticate
gem 'jwt' # jwt
gem 'koala', '~> 2.2' # facebook graph API wrapper
gem 'omniauth' # Oauth
gem 'omniauth-facebook' # Oauth for facebook

# Server-side validation or API related
gem 'active_model_serializers', '~> 0.10.7' # Serializer
gem 'kaminari' # paginate
gem 'pundit' # authorization
gem 'rack-cors', require: 'rack/cors' # CORS
gem 'reform' # for Form Object
gem 'reform-rails' # for Form Object

# Server-side rendered view
gem 'cells' # for View components and cache
gem 'cells-rails' # for View components and cache
gem 'cells-slim' # for View components and cache
gem 'favicon_maker'
gem 'gretel' # breadcrumb
gem 'meta-tags'
gem 'roadie-rails', '~> 1.0' # for eamil
gem 'slim-rails' # using slim as view template
