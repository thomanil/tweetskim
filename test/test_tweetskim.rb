require File.dirname(__FILE__) + '/test_helper.rb'

class TestTweetskim < Test::Unit::TestCase

  def setup
    @t = Tweetskim::TwitterAdapter.new
  end

  def t(text)
    status = Twitter::Status.new
    status.stubs(:text).returns text
    user = Twitter::User.new
    user.stubs(:name).returns "Mock User"
    status.stubs(:user).returns user
    return status
  end
  
  def test_column_creation
    tweets = [t("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "), t("Ut enimad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."), t("Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. "), t("Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")]
    
    expected = <<FORMATTED
[1;34mMock User[0m Excepteur sint
occaecat cupidatat non proident, sunt
in culpa qui officia deserunt mollit
anim id est laborum.


[1;34mMock User[0m Duis aute irure
dolor in reprehenderit in voluptate
velit esse cillum dolore eu fugiat
nulla pariatur.


[1;34mMock User[0m Ut enimad minim
veniam, quis nostrud exercitation
ullamco laboris nisi ut aliquip ex ea
commodo consequat.


[1;34mMock User[0m Lorem ipsum dolor
sit amet, consectetur adipisicing elit,
sed do eiusmod tempor incididunt ut
labore et dolore magna aliqua.
FORMATTED
    assert_equal expected, Tweetskim::Formatter.column(tweets, 40)
  end
  
end

