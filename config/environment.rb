RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

INVITATION_REQUIRED_FOR_SIGNUP = false

Rails::Initializer.run do |config|
  config.load_paths += %W( #{RAILS_ROOT}/app/sweepers/
                           #{RAILS_ROOT}/app/observers/
                           #{RAILS_ROOT}/app/mailers/
                         )

  config.active_record.observers = :entry_match_observer, :goal_observer
  
  config.gem 'httparty'
  config.gem 'stefanpenner-my_scaffold', :lib => false, :source => 'http://gems.github.com'
  config.gem 'ruby-stemmer', :lib => 'lingua/stemmer'
  config.gem 'twitter'
  config.gem 'json'
  config.gem 'authlogic'
  config.gem 'oauth'
  config.gem 'rufus-tokyo'
  config.gem 'thoughtbot-factory_girl', :lib => 'factory_girl', :source => 'http://gems.github.com'

  config.time_zone = 'UTC'

end
require 'lib/enumerable'
require 'rufus/tokyo/tyrant'

TWITTER_LOGIN_CONSUMER_TOKEN  = '5mc9zeVQzhcv8FSU3Hb3Gg'
TWITTER_LOGIN_CONSUMER_SECRET = 'jD0pabQhDkliGWYYrRQSqqjiBEHE61c2t2OjHDDZQ'

DO_NOT_REPLY = "noreply@iboflav.in"

TOKYO = Rufus::Tokyo::Tyrant.new('localhost',45001)

if "irb" == $0
  RAILS_DEFAULT_LOGGER =  Logger.new(STDOUT)
end
