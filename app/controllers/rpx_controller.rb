class RpxController < ApplicationController

  class Rpx
    include HTTParty
    API_KEY = "1ef5c23e2e04de833ed36d8f51e3075f73f61822"
    format :json
    def self.authenticate(token)
      post("https://rpxnow.com/api/v2/auth_info", :query => {:token => token, :apiKey => API_KEY})
    end
  end
  
  def login
    render :text => Rpx.authenticate(params['token']).to_json
  end

end
