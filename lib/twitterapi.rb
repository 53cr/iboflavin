begin
  require 'rubygems'
rescue LoadError; end
require 'twitter'

consumer_token  = 'jEsIetpv9prM9HlqIU52A'
consumer_secret = 'UN5qlRzRtN0gxJnXlsEqEO9qcvsEd6U5IcVGd17UlQ'
access_token    = '40198257-QDDxgjbpigeLLZgczNNduLvGPSwvquBx5o3n6aS8l'
access_secret   = 'fYQtMGZXaet7DIxRcDDedAUKvdyuWT4F9d8wOqIU0g'

oauth = Twitter::OAuth.new(consumer_token, consumer_secret)
oauth.authorize_from_access(access_token, access_secret)

client = Twitter::Base.new(oauth)

SAVE_FILE = 'max_id.save'

$max_id = File.read(SAVE_FILE).to_i

def update_max_id(new_id)
  if new_id > $max_id
    $max_id = new_id
    File.open(SAVE_FILE,'w') {|f| f.puts new_id}
  end
end

loop do
  replies = client.replies(:since_id => $max_id)

  replies.each do |reply|
    update_max_id(reply.id)
    text = reply.text
    user = reply.user.screen_name

    response = "@#{user} I'm not awesome enough to do anything with your query yet."
    puts ">> #{text}"
    puts "<< #{response}"
    client.update(response, :in_reply_to_status_id => reply.id)
  end


  puts "done"
  sleep 60
  
end
