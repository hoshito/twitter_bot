require "twitter"
require "./key"

rest = Twitter::REST::Client.new do |config|
  config.consumer_key        = CONSUMER_KEY
  config.consumer_secret     = CONSUMER_SECRET
  config.access_token        = OAUTH_TOKEN
  config.access_token_secret = OAUTH_TOKEN_SECRET
end

user = ARGV[0]
t_id = ARGV[1]
rest.update("@#{user} remind!", options = {in_reply_to_status_id: t_id})

