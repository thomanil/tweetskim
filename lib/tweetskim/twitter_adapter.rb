# -*- encoding: utf-8 -*-

require 'rubygems'
require 'twitter'
require 'oauth'

module Tweetskim

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
