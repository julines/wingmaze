require 'bundler/capistrano'

default_run_options[:pty] = false
ssh_options[:forward_agent] = true
set :use_sudo, false
set :user, 'julines'

set :domain, "moroni.dreamhost.com"
set :application, "wingmaze"
set :repository, "git@github.com:julines/wingmaze.git"
set :scm, :git
set :stages, %w(staging uat production)
set :default_stage, 'staging'
set :branch, 'master'
set :git_shallow_clone, 1
set :deploy_via, :remote_cache
set :copy_compression, :bz2
set :rails_env, :development
set :deploy_to, "/home/julines/#{application}"

set(:rails_env) { "#{stage}" }

require 'capistrano/ext/multistage'
require 'bundler/capistrano'

# role :web, "#{application}"                          # Your HTTP server, Apache/etc
# role :app, "#{application}"                          # This may be the same as your `Web` server
# role :db,  "#{application}", :primary => true        # This is where Rails migrations will run

task :staging do
  role :app, "#{domain}"
  role :web, "#{domain}"
  role :db,  "#{domain}", :primary => true
  set :stage, :staging
  set :branch, "master"
end

task :uat do
  role :web, "#{domain}"
  role :app, "#{domain}"
  role :db, "#{domain}", :primary => true
  set :stage, :uat
  set :branch, "master"
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

# namespace :deploy do
#   task :restart do
#     run "touch #{current_path}/tmp/restart.txt"
#   end
# end

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end