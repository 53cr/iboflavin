class UserSession < Authlogic::Session::Base

  def self.consumer
    OAuth::Consumer.new(TWITTER_LOGIN_CONSUMER_TOKEN, TWITTER_LOGIN_CONSUMER_SECRET,
    { :site=>"http://twitter.com",
      :authorize_url => "http://twitter.com/oauth/authenticate" })
  end
  
end