require 'capistrano/ext/multistage'

set :stages, %w(staging production)
set :default_stage, "production"

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
      base: &base
        adapter: sqlite3
        timeout: 5000
      development:
        database: #{shared_path}/db/development.sqlite3
        <<: *base
      test:
        database: #{shared_path}/db/test.sqlite3
        <<: *base
      production:
        database: #{shared_path}/db/production.sqlite3
        <<: *base
      EOF

      location = fetch(:template_dir, "config/deploy") + '/database.yml.erb'
      template = File.file?(location) ? File.read(location) : default_template

      config = ERB.new(template)

      run "mkdir -p #{shared_path}/db"
      run "mkdir -p #{shared_path}/config"
      put config.result(binding), "#{shared_path}/config/database.yml"
    end

    desc <<-DESC
      [internal] Updates the symlink for database.yml file to the just deployed release.
    DESC
    task :symlink, :except => { :no_release => true } do
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end

  after "deploy:setup",           "db:setup"   unless fetch(:skip_db_setup, false)
  after "deploy:finalize_update", "db:symlink"

end
