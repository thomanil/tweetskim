# -*- encoding: utf-8 -*-

module Tweetskim

  class Formatter

    def lines(tweets, options = {})
      tweet_texts = tweets.reverse.map {|tweet| "--#{tweet.user.name}-- #{text(tweet)}\n"}
      lines = tweet_texts.join("")
    end
    
    def text(tweet)
      if tweet.retweeted_status
        "RT @#{tweet.retweeted_status.user.screen_name}: #{tweet.retweeted_status.text}"
      else
        tweet.text
      end
    end

    def htmlize(tweet)
      text = text(tweet).gsub('\n', '<br/>')
      "<div class='tweet'><h1>#{tweet.user.name} <span class='time'>#{time(tweet)}</span></h1><p>#{text}<p></div>"
    end

    def time(tweet)
      tweet_time = tweet.created_at
      now = Time.now
      if now.day != tweet_time.day
        "#{tweet_time.day} / #{tweet_time.mon}"
      else
        "#{tweet_time.hour}:#{tweet_time.min}"
      end
    end
    
    def html(tweets, options = {})
      html_tweets = tweets.reverse.map {|tweet| htmlize(tweet)}.join("")

      body = <<HTML
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Tweetskim</title>
  </head>
  <body>
    <style>
      #tweets {
        width: 500px;
        margin-left: 50px;
      }

      .tweet {
         margin-top: 50px;
         margin-bottom: 50px;
      }

      .tweet h1 {
        color: #ADADAD;
        font-size: 2.0em;
        margin-bottom: 0px;
      }

      .tweet .time {
        color: #ADADAD;
        font-size: 0.5em;
      }

      .tweet p {
        font-size: 1.2em;
        margin: 0 0 0 0;
        margin-left: 50px;
        font-family: sans-serif;
      }
    </style>
    <div id="tweets">
      #{html_tweets}
    </div>
  </body>
</html>
HTML
      return body
    end
    
  end
  
end
