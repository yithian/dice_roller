require 'test/unit'
require 'dice_roller'

class CliTest < Test::Unit::TestCase
  def setup
    $TEST = true
    
    @c = DiceRoller::Cli.new(["--four", "1", "--six", "2", "--eight", "3", "--ten", "4", "--twelve", "5", "--twenty", "6", "--percentile", "7", "--type", "successes", "--reroll", "9", "--min", "7", "--sub"])
  end

  def test_parse_options
    assert_equal 1, @c.four, "didn't parse four properly"
    assert_equal 2, @c.six, "didn't parse six properly"
    assert_equal 3, @c.eight, "didn't parse eight properly"
    assert_equal 4, @c.ten, "didn't parse ten properly"
    assert_equal 5, @c.twelve, "didn't parse twelve properly"
    assert_equal 6, @c.twenty, "didn't parse twenty properly"
    assert_equal 7, @c.percentile, "didn't parse percentile properly"
    assert_equal :successes, @c.type, "didn't parse type properly"
    assert_equal 9, @c.reroll, "didn't parse reroll properly"
    assert_equal 7, @c.minimum, "didn't parse min properly"
    assert_equal true, @c.subtract, "didn't parse sub properly"
  end
  
  def test_parse_rote
    @c = DiceRoller::Cli.new(["--type", "successes", "--rote"])
    
    assert_equal 0, @c.reroll, "didn't parse rote properly"
  end
  
  def test_parse_sum
    @c = DiceRoller::Cli.new(["--type", "sum"])
    
    assert_equal :sum, @c.type, "didn't parse type properly"
  end
end
