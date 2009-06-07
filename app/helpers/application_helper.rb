require 'digest/md5'

module ApplicationHelper

  def gravatar(email)
    hash = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{hash}?s=36&r=pg&d=%2Fimages%2Fdefault_avatar.png"
  end

end
