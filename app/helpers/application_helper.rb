require 'digest/md5'

module ApplicationHelper

  def gravatar(email)
    hash = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{hash}?s=36&r=pg&d=http%3A%2F%2F#{APP[:host]}%2Fimages%2Fdefault_avatar.png"
  end

  def javascript_trigger(trigger)
    javascript_tag "$(document).trigger('#{trigger}')"
  end
  
end
