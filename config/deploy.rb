server '127.0.0.1', port: 2222, roles: [:web, :app, :db], primary: true
set :repo_url,        'https://github.com/plombix/Group_app.git'
set :application,     'Group_app'
set :user,            'deploy'
set :puma_threads,    [4, 16]
set :puma_workers,    0
# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, port: 2222,  user: 'deploy', password: "deploy_password" }
# set :ssh_options,     { forward_agent: true, port: 2222,  user: 'deploy', keys: %w(/home/plombix/Sites/Group_app/.vagrant/machines/default/virtualbox/private_key) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord
## Defaults:
set :scm,           :git
set :branch,        :master
set :format,        :pretty
set :log_level,     :debug
set :keep_releases, 5
## Linked Files & Directories (Default None):
set :linked_files, %w{config/database.yml}
set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end
  before :start, :make_dirs
end
namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end
  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end
  desc 'Seeding Database'
  task :seed do
   puts "\n=== Seeding Database ===\n"
   on primary :db do
    within current_path do
      with rails_env: fetch(:stage) do
        execute :rake, 'db:seed'
      end
    end
   end
  end

  desc 'Migrating Down Database'
  task :migrate_down do
   puts "\n=== Migrating Up Database ===\n"
   on primary :db do
    within current_path do
      with rails_env: fetch(:stage) do
        execute :rake, 'db:migrate VERSION=0 --trace'
      end
    end
   end
  end

  desc 'Migrating Up Database'
  task :migrate_up do
   puts "\n=== Migrating Up Database ===\n"
   on primary :db do
    within current_path do
      with rails_env: fetch(:stage) do
        execute :rake, 'db:migrate --trace'
      end
    end
   end
  end
  

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
