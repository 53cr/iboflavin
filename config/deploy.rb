set :application, "b2.iboflav.in"
set :domain,      "b2.iboflav.in"
set :deploy_to,   "/srv/rails/b2.iboflav.in/"
set :repository,  "git@github.com:53cr/iboflavin.git"
set :sudo_flags, ''
set :web_command, 'sudo /etc/rc.d/nginx'	
set :migrate_target, :current
