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
    
    expected = <<COLUMN
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
COLUMN

    actual = @f.column(tweets, {:width => 40})
        
    assert_equal expected, actual
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


  def test_whitespace_padding

    col = <<COL
aaaaaa
aaaaa
aaaa
aaa
aa
a

COL
    
    expected = <<COL
aaaaaa
aaaaa 
aaaa  
aaa   
aa    
a     
      
COL
       
    assert_equal expected, @f.pad(col, 6)
  end
  
end

