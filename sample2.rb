require "twitter"

puts "1====="
CONSUMER_KEY       = ''
CONSUMER_SECRET    = ''
OAUTH_TOKEN        = ''
OAUTH_TOKEN_SECRET = ''
client_rest = Twitter::REST::Client.new do |config|
  config.consumer_key        = CONSUMER_KEY
  config.consumer_secret     = CONSUMER_SECRET
  config.access_token        = OAUTH_TOKEN
  config.access_token_secret = OAUTH_TOKEN_SECRET
end
puts "2====="

return if ARGV.length != 4

num = ARGV[0]
user = ARGV[1]
text = ARGV[2]
id = ARGV[3]
puts "------"
puts num
puts user
puts text
puts id

sleep(num.to_i * 60 * 60)
client_rest.update("@#{user} #{text}, ", options = {in_reply_to_status_id: id})

