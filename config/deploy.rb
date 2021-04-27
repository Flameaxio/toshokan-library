# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

set :application, "toshokan-library"
set :repo_url, "git@github.com:Flameaxio/toshokan-library.git"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/toshokan-library'
set :deploy_user, 'deployer'

set :init_system, :systemd

append :linked_files, 'config/database.yml', 'config/credentials.yml.enc', 'config/master.key'

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'public/uploads'

set :bundle_flags, "--deployment"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
      #invoke 'unicorn:restart'
    end
  end

  after :publishing, :restart
end
