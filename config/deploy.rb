set :application, "b2.iboflav.in"
set :deploy_to,   "/srv/rails/#{application}/"

set :scm,        :git
set :branch,     "master"
set :repository, "git@github.com:53cr/iboflavin.git"
set :deploy_via, :remote_cache

set :use_sudo, true

set :user,   :burke
set :domain, application
server domain, :app, :web
role :db, domain, :primary => true

namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after :deploy, "passenger:restart"

namespace :deploy do
  
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end
