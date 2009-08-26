set :application, "core"
set :domain,      "core.53cr.com"
set :deploy_to,   "/srv/rails/base.53cr.com."
set :repository,  "git@53cr.com:core.git"
set :sudo_flags, ''
set :web_command, 'sudo /etc/rc.d/nginx'	
set :migrate_target, :current

