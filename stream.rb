require "twitter"

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

client_stream = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = CONSUMER_KEY
  config.consumer_secret     = CONSUMER_SECRET
  config.access_token        = OAUTH_TOKEN
  config.access_token_secret = OAUTH_TOKEN_SECRET
end

client_stream.user do |object|
  if object.is_a?(Twitter::Tweet) && object.user.screen_name != ""
    puts object.user.screen_name
      #=> ツイートしたユーザの screen name (e.g.: owatan_)
    puts object.text
      #=> ツイート本文 (e.g.: うさちゃん、うさちゃん、ぴょんぴょんぴょーん♪)
    puts object.id
      #=> ツイートの ID (e.g.: 497366451490021376)
    puts object.user.name
      #=> ツイートしたユーザの名前 (e.g.: おわたん)
    puts object.source
      #=> ツイートしたクライアント
      #=> e.g.: <a href="http://sites.google.com/site/yorufukurou/" rel="nofollow">YoruFukurou</a>
      #=> a 要素が入っているので、クライアント名だけを抽出したい時は以下のように #gsub を使うと良い
    puts object.source.gsub(/(<a href=".*" rel=".*">)(.*)(<\/a>)/, '\2')
      #=> ツイートしたクライアント名(e.g.: YoruFukurou)

    hour = object.text.match(/([0-9]+)hour/)
    puts hour
    unless hour.nil?
      num = $1
      puts num
      spawn "ruby ./sample2.rb #{num} #{object.user.screen_name} '#{object.text}' #{object.id}"
    end

    #if object.text =~ /ふぁぼ/
    #  client_rest.favorite(object.id)
    #    #=> "ふぁぼ" という文字列が含まれているツイートをお気に入りに追加する
    #end

    #if object.text =~ /りついーと/
    #  client_rest.retweet(object.id)
    #  #=> "りついーと" という文字列が含まれているツイートをリツイートする
    #end
  end
end
