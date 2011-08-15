require 'bundler/capistrano'
# set :application, "set your application name here"
# set :repository,  "set your repository location here"
# 
# set :scm, :subversion
# # Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
# 
# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

default_run_options[:pty] = false
ssh_options[:forward_agent] = true
set :use_sudo, false
set :user, 'julines'

# set :domain, 'wingmaze'

set :domain, 'julinesliong.com'
set :application, "wingmaze"
set :repository,  "git@github.com:julines/wingmaze.git"
set :scm, :git
set :stages, %w(development uat production)
# set :branch, 'master'
set :git_shallow_clone, 1
set :deploy_via, :remote_cache
set :copy_compression, :bz2
set :rails_env, 'production'
set :deploy_to, "/home/julines/#{application}"

role :web, "#{application}"                          # Your HTTP server, Apache/etc
role :app, "#{application}"                          # This may be the same as your `Web` server
role :db,  "#{application}", :primary => true        # This is where Rails migrations will run

task :development do
  role :app, "#{domain}"
  role :web, "#{domain}"
  role :db,  "#{domain}", :primary => true
  set :stage, :development
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