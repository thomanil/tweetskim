# -*- encoding: utf-8 -*-

module Tweetskim
  require 'rubygems'
  require 'twitter'
  require 'oauth'
    
  class TwitterAdapter
    
    def trial 
     4
    end

    # Note: use status.id_str as id, not raw id
    
    def mentions_since(tweet_id)
      ["Lorem ipsum dolor sit amet",
       "consectetur adipisicing elit"]
    end

    def timeline_since(tweet_id)
      ["@Lorem ipsum dolor sit amet",
       "@consectetur adipisicing elit"]
    end


    CONSUMER_KEY = "3oUZhYLZcaqqQePajIjnBg"
    CONSUMER_SECRET = "mAYecEGPwy7BlkibFGHCACtY5x1Mm0YOvczxsll4OY"
    
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
      
      print "What was the PIN Twitter gave you? "
      pin = gets.chomp
     
      OAuth::RequestToken.new(oauth_consumer, rtoken, rsecret)
      access_token = request_token.get_access_token(:oauth_verifier => pin)
      
      return access_token.token, access_token.secret
    end

    def mentions
      client = authenticated_client
      mentions = client.mentions("thomanil")[0...10].map { |tweet| tweet.text }
      return mentions
    end
    
    TOKEN_FILE_PATH = File.expand_path "~/.tweetskim/tokens"
    
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
