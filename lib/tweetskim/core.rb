# -*- encoding: utf-8 -*-

module Tweetskim
  require 'rubygems'
  require 'twitter'
  require 'oauth'


  class Formatter
    def lines(tweets, options = {})
      tweet_texts = tweets.reverse.map {|tweet| "--#{tweet.user.name}-- #{text(tweet)}\n"}
      lines = tweet_texts.join("")
    end
      
    def column(tweets, options = {})
      tweet_texts = tweets.reverse.map {|tweet| "--\\033[1;34m#{tweet.user.name}\\033[0m-- #{text(tweet)}"}
      reflowed_tweets = tweet_texts.map {|tweet| `echo "#{tweet}" | fmt -w #{options[:width]}` }
      column = reflowed_tweets.join "\n\n"
    end

    def pad(column, width)
      padded_lines = []
      column.each_line do |line|
        chopped_line = line.chop
        padded_lines.push `printf "%-#{width}s\n" "#{chopped_line}"`        
      end
      padded_lines.join ""
    end

    def text(tweet)
      if tweet.retweeted_status
        "RT @#{tweet.retweeted_status.user.screen_name}: #{tweet.retweeted_status.text}"
      else
        tweet.text
      end
    end
      
  end


  class Settings
    SETTINGS_TEMPLATE = {:token => nil,
      :secret => nil,
      :last_read_status_id => "111111"}

    SETTINGS_FILE_PATH = File.expand_path "~/.tweetskim/default-account"

    require "fileutils"
    
    def initialize
      FileUtils.mkdir_p(File.expand_path("~/.tweetskim"))
      FileUtils.touch SETTINGS_FILE_PATH
    end
    
    def load
      File.open SETTINGS_FILE_PATH, "r" do |filebody|
        YAML::load(filebody) || SETTINGS_TEMPLATE
      end
    end

    def save(settings)
      yml_str = YAML::dump(settings)
      File.open SETTINGS_FILE_PATH, "w" do |filebody|
        filebody.write yml_str
      end
    end
    
    def user_credentials_stored?
      if File.exists? SETTINGS_FILE_PATH
        settings = load
        return (settings[:token] && !settings[:token].empty? &&
                settings[:secret] && !settings[:secret].empty?)
      else
        false
      end
    end
    
    def save_credentials(token, secret)
      settings = load
      settings[:token] = token
      settings[:secret] = secret
      save settings
    end

    def load_credentials
      settings = load
      return settings[:token], settings[:secret]
    end

    def load_last_read_status_id
      settings = load
      return settings[:last_read_status_id]
    end

    def save_last_read_status_id(id)
      settings = load
      settings[:last_read_status_id] = id
      save settings
    end
    
  end


  
  class TwitterAdapter
    # TODO call for each user in config
    # implicit for the user authenticated in client. Different user =
    # different client
    
    def mentions(tweet_count, since_id)
      client = authenticated_client 
      mentions = client.mentions({:count => tweet_count.to_i, :since_id => since_id.to_i})
    end

    def timeline(tweet_count, since_id) 
      client = authenticated_client
      timeline = client.home_timeline({:count => tweet_count.to_i, :since_id => since_id.to_i})
    end
    
    CONSUMER_KEY = "3oUZhYLZcaqqQePajIjnBg"
    CONSUMER_SECRET = "mAYecEGPwy7BlkibFGHCACtY5x1Mm0YOvczxsll4OY"

    # TODO call for specific user
    def authenticated_client
      settings = Tweetskim::Settings.new
      
      if settings.user_credentials_stored?
        user_token, user_secret = settings.load_credentials
      else
        user_token, user_secret = oauth_pin_dance_for_token_and_secret
        settings.save_credentials(user_token, user_secret)
      end

      Twitter.configure do |config|
        config.consumer_key = CONSUMER_KEY
        config.consumer_secret = CONSUMER_SECRET
        config.oauth_token = user_token
        config.oauth_token_secret = user_secret
      end

      client = Twitter::Client.new
      client.verify_credentials
      return client
    end
    
    def oauth_pin_dance_for_token_and_secret
      oauth_consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET,
                                           :site => 'http://api.twitter.com',
                                           :request_token_path => '/oauth/request_token',
                                           :access_token_path => '/oauth/access_token',
                                           :authorize_path => '/oauth/authorize')
      
      request_token = oauth_consumer.get_request_token
      rtoken  = request_token.token
      rsecret = request_token.secret
      
      puts "You have to set up Twitter authentication the first time you use tweetskim."
      puts "Please authenticate by following this URL:"
      puts request_token.authorize_url
      
      puts "What was the PIN that Twitter gave you? "
      pin = gets.chomp
     
      OAuth::RequestToken.new(oauth_consumer, rtoken, rsecret)
      access_token = request_token.get_access_token(:oauth_verifier => pin)
      
      return access_token.token, access_token.secret
    end   
  end
  
end
