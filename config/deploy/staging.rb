#############################################################
# Comments: We don't really use multi-staged deployment here,
#           so test test test if you need it!
#############################################################

#############################################################
#	Application
#############################################################

set :application, "beans"
set :deploy_to, "/var/www/apps/staging/beans"
set :dbuser, "beans"
set :dbhost, "db.beyond150.com" # apps.beyond150.com = db.beyond150.com

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :use_sudo, false
set :scm_verbose, true
set :rails_env, "staging" 

#############################################################
#	Servers
#############################################################

set :user, "beyond150"
set :domain, "apps.beyond150.com"
server domain, :app, :web
role :db, domain, :primary => true

#############################################################
#	Git
#############################################################

set :scm, :git
set :branch, "master"
set :repository, "ssh://git.beyond150.com/var/git/beans.git"
set :deploy_via, :remote_cache

#############################################################
#	Passenger
#############################################################

before "deploy:symlink", "deploy:symlink_uploads"
namespace :deploy do
    
  # Symlink an uploads directory, just change the paths to whatever you need.
  desc "Symlink the upload directories"
  task :symlink_uploads do
    run "mkdir -p #{shared_path}/uploads"
    run "ln -s #{shared_path}/uploads #{release_path}/public/uploads"
  end
    
  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
end