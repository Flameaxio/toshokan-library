# config valid for current version and patch releases of Capistrano
lock '~> 3.16.0'

set :application, 'toshokan-library'
set :repo_url, 'git@github.com:Flameaxio/toshokan-library.git'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/toshokan-library'
set :deploy_user, 'deployer'

set :init_system, :systemd

append :linked_files, 'config/database.yml', 'config/master.key', '.env.production'

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'public/uploads', '.bundle', 'node_modules'

# capistrano-rails config
set :assets_roles, %i[webpack] # Give the webpack role to a single server
set :assets_prefix, 'packs' # Assets are located in /packs/
set :keep_assets, 10 # Automatically remove stale assets
set :assets_manifests, lambda { # Tell Capistrano-Rails how to find the Webpacker manifests
  [release_path.join('public', fetch(:assets_prefix), 'manifest.json*')]
}

set :conditionally_migrate, true # Only attempt migration if db/migrate changed - not related to Webpacker, but a nice thing

set :bundle_flags, '--deployment'

set :default_env, {
  'PATH' => '/home/deployer/.nvm/versions/node/v12.22.1/bin:$PATH'
}

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

after 'deploy:updated', 'webpacker:precompile'

namespace :deploy do
  namespace :assets do
    before :precompile, :own
    task :own do
      on roles(:app), in: :sequence, wait: 5 do
        execute :chmod, '-R', '777', '/var/www/toshokan-library/releases'
      end
    end
  end
  #
  #  task :fix_endings do
  #    on roles(:app), in: :sequence, wait: 5 do
  #      execute :git, 'config', '--global', 'core.autocrlf', 'false'
  #      execute :find, './', '-type', 'f', '-exec', 'dos2unix', '{}', '\\;'
  #    end
  #  end
  #
  #  before :precompile, :fix_endings
  #end
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
      #invoke 'unicorn:restart'
    end
  end

  after :publishing, :restart
end

#before 'deploy:assets:precompile', 'deploy:yarn_install'
#namespace :deploy do
#  desc 'Run rake yarn install'
#  task :yarn_install do
#    on roles(:web) do
#      within release_path do
#        execute("cd #{release_path} && yarn install --silent --no-progress --no-audit --no-optional")
#      end
#    end
#  end
#end
