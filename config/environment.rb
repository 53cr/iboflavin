RAILS_GEM_VERSION = '2.3.3' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  config.gem 'mocha'
  config.gem 'thoughtbot-factory_girl',  :lib => 'factory_girl', :source => "http://gems.github.com"
  config.gem 'authlogic'
  config.gem 'thoughtbot-paperclip',     :lib => 'paperclip',    :source => "http://gems.github.com"
  config.gem 'crafterm-comma',           :lib => 'comma',        :source => "http://gems.github.com"
  config.gem 'chriseppstein-compass',    :lib => 'compass',      :source => "http://gems.github.com"
  config.gem 'haml'
  config.gem 'fastercsv'
  config.gem "mongodb-mongo", :version => '0.11.1', :lib => "mongo", :source => "http://gems.github.com" 
  config.gem "jnunemaker-mongomapper", :lib => "mongomapper", :source => "http://gems.github.com"
    
  config.load_paths += %W( #{RAILS_ROOT}/app/sweepers/
                           #{RAILS_ROOT}/app/observers/
                           #{RAILS_ROOT}/app/mailers/)
  
  config.time_zone = 'UTC'

  config.action_controller.session = {
    :session_key => '_base_session',
    :secret      => 'db41de5aa5f94f31138ef67e73ce7163a08323d5499ce01b9455253e9670a5113e9cd7cc774f503668d0e1446efe6499884eb2d4e74283fbf726df264792168e'
  }

  config.active_record.observers = :user_observer
end


MongoMapper.connection = XGen::Mongo::Driver::Mongo.new('192.168.1.18')
MongoMapper.database = 'iboflavin'