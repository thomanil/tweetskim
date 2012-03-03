require File.dirname(__FILE__) + '/test_helper.rb'

class TestTweetskim < Test::Unit::TestCase

  def setup
    @f = Tweetskim::Formatter.new
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
    tweets = [t("Ut enimad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."), t("Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. "), t("Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")]
    
    expected = <<FORMATTED
--Mock User-- Excepteur sint occaecat
cupidatat non proident, sunt in culpa
qui officia deserunt mollit anim id
est laborum.


--Mock User-- Duis aute irure dolor in
reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur.


--Mock User-- Ut enimad minim veniam,
quis nostrud exercitation ullamco
laboris nisi ut aliquip ex ea commodo
consequat.
FORMATTED

    actual = @f.column(tweets, 40)
        
    assert_equal expected, @f.column(tweets, 40)
  end

  def test_column_pasting
    first_col = <<COL
aaa
aaa
aaa
COL
    second_col = <<COL
bbb
bbb
bbb
COL

    expected = <<COL
aaa\tbbb
aaa\tbbb
aaa\tbbb
COL

    assert_equal expected, @f.pasted_columns([first_col, second_col])
  end
  
end

