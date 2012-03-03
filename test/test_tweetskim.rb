require File.dirname(__FILE__) + '/test_helper.rb'

class TestTweetskim < Test::Unit::TestCase

  def setup
    @t = Tweetskim::TwitterAdapter.new
  end
  
  def test_something
    assert_equal 4, @t.trial
  end

  def test_twitter_integration_get_mentions
    assert_equal 10, @t.mentions[0...10].count
  end

  def test_twitter_integration_get_timeline
    assert_equal 10, @t.timeline[0...10].count
  end

  
  def test_column_creation
    tweet_str = ["Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ", "Ut enimad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ", "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."]

#    tweets = tweet_str.map { |str| Twitter::Status.new :text => str }
    
    puts @t.tweet_column( @t.timeline, 40)
  end
  
end

