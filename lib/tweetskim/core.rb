# -*- encoding: utf-8 -*-

module Tweetskim
  require 'rubygems'
  require 'twitter'
  require 'oauth'


  class Formatter
    
    def column(tweets, options = {})
      tweet_texts = tweets.reverse.map {|tweet| "--#{tweet.user.name}-- #{tweet.text}"}
      reflowed_tweets = tweet_texts.map {|tweet| `echo "#{tweet}" | fmt -w #{options[:width]}` }
      column = reflowed_tweets.join "\n\n"
    end

    def pad(column, width)
      padded_lines = []
      column.each_line do |line|
        padded_line = line.gsub "\n", ""
        line_width = padded_line.size
        if line_width < width
          missing_spaces = width - line_width
          missing_spaces.times { padded_line += " " }
        end
        padded_lines.push(padded_line+"\n")
      end
      padded_lines.join ""
    end
      
    def pasted_columns(columns)
      col_tmp_files = []

      columns.each_with_index do |col, i|
        filepath = "/tmp/tweetskim-col#{i}.txt"
        `rm #{filepath}; echo "#{col}" > #{filepath}`
        col_tmp_files.push filepath
      end

      col_tmp_files = col_tmp_files.join " "
      `paste #{col_tmp_files}`.chomp "\t\n"
    end
      
  end

  
  class TwitterAdapter
      
    # TODO call for each user in config
    # implicit for the user authenticated in client. Different user =
    # different client
    def mentions(options = {})
      client = authenticated_client # 
      mentions = client.mentions(options)
    end

    def timeline(options = {}) 
      client = authenticated_client
      timeline = client.home_timeline(options)
    end
    
    CONSUMER_KEY = "3oUZhYLZcaqqQePajIjnBg"
    CONSUMER_SECRET = "mAYecEGPwy7BlkibFGHCACtY5x1Mm0YOvczxsll4OY"

    # TODO call for specific user
    def authenticated_client
      if user_tokens_stored?
        user_token, user_secret = load_user_tokens
      else
        user_token, user_secret = oauth_pin_dance_for_token_and_secret
        store_user_tokens(user_token, user_secret)
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
      
      print "What was the PIN that Twitter gave you? "
      pin = gets.chomp
     
      OAuth::RequestToken.new(oauth_consumer, rtoken, rsecret)
      access_token = request_token.get_access_token(:oauth_verifier => pin)
      
      return access_token.token, access_token.secret
    end

    #TODO store tokens for each user
    TOKEN_FILE_PATH = File.expand_path "~/.tweetskim/default.tokens"
    
    def user_tokens_stored?
      File.exists? TOKEN_FILE_PATH
    end
    
    def store_user_tokens(token, secret)
      `mkdir ~/.tweetskim/`
       `echo "#{token}___#{secret}" > #{TOKEN_FILE_PATH}`
    end

    def load_user_tokens
      token, secret = `cat #{TOKEN_FILE_PATH}`.split "___"
      return token.chomp, secret.chomp
    end
        
  end
end
