# -*- encoding: utf-8 -*-

module Tweetskim

  require 'rubygems'
  require 'twitter'
  require 'oauth'
    
  class TwitterAdapter
    CONSUMER_KEY = "3oUZhYLZcaqqQePajIjnBg"
    CONSUMER_SECRET = "mAYecEGPwy7BlkibFGHCACtY5x1Mm0YOvczxsll4OY"
    
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


    def authenticated_client
      consumer_key = '3oUZhYLZcaqqQePajIjnBg'
      consumer_secret = 'mAYecEGPwy7BlkibFGHCACtY5x1Mm0YOvczxsll4OY'

      user_token, user_secret = song_and_dance_for_tokens
      
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
      consumer_key = '3oUZhYLZcaqqQePajIjnBg'
      consumer_secret = 'mAYecEGPwy7BlkibFGHCACtY5x1Mm0YOvczxsll4OY'
      
      oauth_consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET,
                                     :site => 'http://api.twitter.com',
                                     :request_endpoint => 'http://api.twitter.com',
                                     :sign_in => true)

      request_token = oauth_consumer.get_request_token
      rtoken  = request_token.token
      rsecret = request_token.secret
      
      puts "Now visit the following URL:"
      puts request_token.authorize_url
      
      print "What was the PIN Twitter gave you? "
      pin = gets.chomp
     
      OAuth::RequestToken.new(oauth_consumer, rtoken, rsecret)
      access_token = request_token.get_access_token(:oauth_verifier => pin)

      # TODO store these after first time
      token = access_token.token
      secret = access_token.secret
      
      return token, secret
    end

    
    def mentions
      client = authenticated_client
      mentions = client.mentions("thomanil")[0...10].map { |tweet| tweet.text }
      return mentions
    end

    def store_user_access_token
      # store in ~/.tweetskim/token
    end

    def load_user_access_token
      # store in ~/.tweetskim/token
    end
      

    
  end
end
