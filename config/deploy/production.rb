#############################################################
#	Application
#############################################################

set :deploy_to, "/var/www/apps/production/beans"

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :use_sudo, false
set :scm_verbose, true
set :rack_env, "production" 

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

set :branch, "minified"

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