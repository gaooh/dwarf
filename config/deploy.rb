set :application, "dwarf"
set :repository,  "http://labs.gaooh.com/svn/#{application}/trunk"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
set :scm, :subversion 
set :scm_username, "gaooh"
set :scm_password, "sabosabo"

set :user, "asami"
set :gateway, "gateway.drecom.co.jp"
set :ssh_options, :forward_agent => true, :port => 10022

role :app, "192.168.50.151", :port => 10022
role :web, "192.168.50.151", :port => 10022
role :db,  "192.168.50.151", :primary => true, :port => 10022

set :deploy_to, "/usr/local/site/cobit3/"
set :current_path, "#{deploy_to}current"
set :user, "asami"

set :use_sudo, false
set :checkout, "export"

set :mongrel_user, "root"
set :mongrel_path, "/usr/local/bin/mongrel_rails"

desc "Restart the web server"
task :restart, :roles => :app do
  begin
    run "cd #{current_path} && sudo -u #{mongrel_user} #{mongrel_path} restart"
  rescue RuntimeError => e
    puts e
  end
end

desc "Start the web server"
task :spinner, :roles => :app do
  begin
    run "cd #{current_path} && sudo -u #{mongrel_user} #{mongrel_path} start -d -e production"
  rescue RuntimeError => e
    puts e
  end
end

desc "Stop the web server"
task :stop, :roles => :app do
  begin
    run "cd #{current_path} && sudo -u #{mongrel_user} #{mongrel_path} stop"
  rescue RuntimeError => e
    puts e
  end
end
