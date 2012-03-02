require File.dirname(__FILE__) + '/test_helper.rb'

class TestTweetskim < Test::Unit::TestCase
  
  def test_something
    assert_equal 4, Tweetskim::TwitterAdapter.new.trial
  end

  def test_get_mentions
    assert_equal 10, Tweetskim::TwitterAdapter.new.mentions.count
  end

  
end

