# run with:  god -c /path/to/iboflavin.god

# APP_ROOT   = "/Users/burke/src/iboflavin"
# RAILS_ROOT = APP_ROOT

APP_ROOT   = "/srv/rails/b2.iboflav.in"
RAILS_ROOT = "#{APP_ROOT}/current"

God.load(File.join(File.dirname(__FILE__),"/services/*.god"))

