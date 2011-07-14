require 'capistrano/ext/multistage'
set :default_stage, "production"

set :application, "beans"
set :repository,  "ssh://git.beyond150.com/var/git/beans.git"

set :scm, :git
set :deploy_via, :remote_cache

role :web, "apps.beyond150.com"                          # Your HTTP server, Apache/etc
role :app, "apps.beyond150.com"                          # This may be the same as your `Web` server
role :db,  "db1.beyond150.com", :primary => true # This is where Rails migrations will run
role :db,  "db1.beyond150.com"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :db do
  desc 'Dumps the production database to db/production_data.sql on the remote server'
  task :remote_db_dump, :roles => :db, :only => { :primary => true } do
    run "cd #{deploy_to}/#{current_dir} && " +
      "rake RAILS_ENV=#{rails_env} db:database_dump --trace" 
  end

  desc 'Downloads db/production_data.sql from the remote production environment to your local machine'
  task :remote_db_download, :roles => :db, :only => { :primary => true } do  
    execute_on_servers(options) do |servers|
      self.sessions[servers.first].sftp.connect do |tsftp|
        tsftp.download!("#{deploy_to}/#{current_dir}/db/production_data.sql", "db/production_data.sql")
      end
    end
  end

  desc 'Cleans up data dump file'
  task :remote_db_cleanup, :roles => :db, :only => { :primary => true } do
    execute_on_servers(options) do |servers|
      self.sessions[servers.first].sftp.connect do |tsftp|
        tsftp.remove! "#{deploy_to}/#{current_dir}/db/production_data.sql" 
      end
    end
  end 

  desc 'Dumps, downloads and then cleans up the production data dump'
  task :remote_db_runner do
    remote_db_dump
    remote_db_download
    remote_db_cleanup
  end

  desc <<-DESC
    Creates the database.yml configuration file in shared path.

    By default, this task uses a template unless a template \
    called database.yml.erb is found either is :template_dir \
    or /config/deploy folders. The default template matches \
    the template for config/database.yml file shipped with Rails.

    When this recipe is loaded, db:setup is automatically configured \
    to be invoked after deploy:setup. You can skip this task setting \
    the variable :skip_db_setup to true. This is especially useful \
    if you are using this recipe in combination with \
    capistrano-ext/multistaging to avoid multiple db:setup calls \
    when running deploy:setup for all stages one by one.
  DESC
  task :setup, :except => { :no_release => true } do
    default_template = <<-EOF
      defaults: &defaults
        host: localhost
        # slaves:
        #   - host: slave1.local
        #     port: 27018
        #   - host: slave2.local
        #     port: 27019

      development:
        <<: *defaults
        database: beans_development

      test:
        <<: *defaults
        database: beans_test

      # set these environment variables on your prod server
      production:
        # host: <%= ENV['MONGOID_HOST'] %>
        # port: <%= ENV['MONGOID_PORT'] %>
        # username: <%= ENV['MONGOID_USERNAME'] %>
        # password: <%= ENV['MONGOID_PASSWORD'] %>
        # database: <%= ENV['MONGOID_DATABASE'] %>
        database: beans_production
    EOF

    location = fetch(:template_dir, "config/deploy") + '/mongoid.yml.erb'
    template = File.file?(location) ? File.read(location) : default_template

    config = ERB.new(template)

    # run "mkdir -p #{shared_path}/db"
    run "mkdir -p #{shared_path}/config"
    put config.result(binding), "#{shared_path}/config/mongoid.yml"
  end

  desc <<-DESC
    [internal] Updates the symlink for database.yml file to the just deployed release.
  DESC
  task :symlink, :except => { :no_release => true } do
    run "ln -nfs #{shared_path}/config/mongoid.yml #{release_path}/config/mongoid.yml"
  end

  after "deploy:setup",           "db:setup"   unless fetch(:skip_db_setup, false)
  after "deploy:finalize_update", "db:symlink"

end
