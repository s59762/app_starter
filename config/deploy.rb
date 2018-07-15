'ssh-add'

require 'capistrano-db-tasks'

# config valid only for Capistrano 3.1

set :application, ENV['app_name'].classify
# set :repo_url, 'git@github.com:oracle-design/kaishall.git'
set :repo_url, %(git@github.com:oracle-design/#{ENV['app_name']}.git)
set :branch, ENV['BRANCH'] if ENV['BRANCH']
set :deploy_to, %(/home/deployer/websites/#{ENV['app_name']})

set :linked_files, %w(config/database.yml)
set :linked_files, %w(config/database.yml config/application.yml config/secrets.yml)
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads)
set :assets_dir, %w(public/uploads)
set :local_assets_dir, %w(public)

# Default value for keep_releases is 5
# set :keep_releases, 5

# Slack integration
set :slack_webhook, ENV['slack_webhook']
set :slack_team, ENV['slack_team']
set :slack_channel, ENV['slack_channels'].split(',')

set :slack_icon_url,         -> { 'http://gravatar.com/avatar/885e1c523b7975c4003de162d8ee8fee?r=g&s=40' }
set :slack_icon_emoji,       -> { ':shipit:' } # will override icon_url, Must be a string (ex: ':shipit:')
set :slack_channel,          -> { '#deploy-notification' }
set :slack_username,         -> { 'Deploy-Bot' }
set :slack_run_starting,     -> { true }
set :slack_run_finished,     -> { true }
set :slack_msg_updating,     -> { ":rocket: #{ENV['USER'] || ENV['USERNAME']} 正在將 #{fetch :application} 的 #{fetch :branch} 分支部署到 #{fetch(:stage)} :computer:" }
set :slack_msg_updated, -> { ":pray: #{fetch :application} 部署成功，#{ENV['USER'] || ENV['USERNAME']} 好棒棒 :kissing_heart:" }
set :slack_fields_updated, [
  {
    title: '專案名稱',
    value: fetch(:application).to_s,
    short: true
  },
  {
    title: '環境',
    value: fetch(:stage),
    short: true
  },
  {
    title: '部署者',
    value: fetch(:slack_deploy_user),
    short: true
  }
]

set :slack_msg_failed, -> { ":shit: #{fetch :application} 部署失敗。 :no_good:" }

set :sidekiq_queue, ["#{ENV['app_name']}_#{fetch(:stage)}_default", "#{ENV['app_name']}_#{fetch(:stage)}_mailers"]

Rake::Task['deploy:compile_assets'].clear

namespace :deploy do
  desc 'Compile assets'
  task compile_assets: [:set_rails_env] do
    invoke 'deploy:assets:precompile_local'
    invoke 'deploy:assets:backup_manifest'
  end

  namespace :assets do
    desc 'Precompile assets locally and then rsync to web servers'
    task :precompile_local do
      local_assets_dir = './public/assets/'
      local_packs_dir = './public/packs/'
      temp_packs_dir = './tmp/packs/'

      # move current pack assets to tmp
      run_locally { execute "mv #{local_packs_dir} #{temp_packs_dir}" }

      # compile assets locally
      run_locally { execute "RAILS_ENV=#{fetch(:stage)} bundle exec rake assets:precompile" }

      # rsync to each server
      on roles(fetch(:assets_roles, [:web])) do
        remote_assets_dir = "#{host.user}@#{host.hostname}:#{release_path}/public/assets/"
        remote_packs_dir = "#{host.user}@#{host.hostname}:#{release_path}/public/packs/"

        run_locally { execute "rsync -av --delete #{local_assets_dir} #{remote_assets_dir}" }
        run_locally { execute "rsync -av --delete #{local_packs_dir} #{remote_packs_dir}" }
      end

      # clean up assets that synced to remote server successfully
      run_locally { execute "rm -rf #{local_assets_dir}" }
      run_locally { execute "rm -rf #{local_packs_dir}" }

      # move current assets back from tmp
      run_locally { execute "mv #{temp_packs_dir} #{local_packs_dir}" }
      run_locally { execute "bundle exec yarn install" }
    end
  end
end

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
