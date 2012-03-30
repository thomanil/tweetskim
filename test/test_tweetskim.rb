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

  def test_line_creation
    tweets = [t("Ut enimad minim veniam, quis nostrud."), t("Duis aute irure dolor in reprehenderit"), t("Excepteur sint occaecat cupidatat non proident")]

    expected = <<LINES
--Mock User-- Excepteur sint occaecat cupidatat non proident
--Mock User-- Duis aute irure dolor in reprehenderit
--Mock User-- Ut enimad minim veniam, quis nostrud.
LINES

    actual = @f.lines(tweets);

    assert_equal expected, actual
  end
  
end

