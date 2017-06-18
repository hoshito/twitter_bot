require "twitter"
require "./key"

stream = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = CONSUMER_KEY
  config.consumer_secret     = CONSUMER_SECRET
  config.access_token        = OAUTH_TOKEN
  config.access_token_secret = OAUTH_TOKEN_SECRET
end

rest = Twitter::REST::Client.new do |config|
  config.consumer_key        = CONSUMER_KEY
  config.consumer_secret     = CONSUMER_SECRET
  config.access_token        = OAUTH_TOKEN
  config.access_token_secret = OAUTH_TOKEN_SECRET
end


stream.user do |object|
  if object.is_a?(Twitter::Tweet) && object.user.screen_name != BOT_USER
    user = object.user.screen_name
    t_id = object.id
    hour = object.text.match(/([0-9\.]+)hour/)
    unless hour.nil?
      str_t = (Time.now + hour[1].to_f * 60 * 60).strftime("%H:%M %d.%m.%Y")
      rest.update("@#{user} OK! #{str_t}", options = {in_reply_to_status_id: t_id})
      IO.popen("at -q r '#{str_t}'","w"){|io| 
        io.puts "#/bin/sh 
        ruby /home/hoshito/git/ruby/twitter_bot/tweet.rb #{user} #{t_id}"
      }
    end
  end
end
