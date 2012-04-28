require 'test/unit'
require 'dice_roller'

class DicePoolTest < Test::Unit::TestCase
  def setup
    @dr = DiceRoller::DiceResult.new([1], [1], [1], [1, 4, 9, 10], [1], [1], [1])
  end

  def test_total
    assert_equal 30, @dr.total, "sum didn't calculate correctly"
  end

  def test_successes_normal
    suxx = @dr.successes
    
    assert suxx >= 2, "should have rolled more successes"
    assert @dr.ten_result.count >= 5, "didn't reroll a 10"
  end
  
  def test_successes_minimum
    suxx = @dr.successes(10)
    
    assert suxx >= 1, "should have rolled more successes"
    assert @dr.ten_result.count >= 5, "didn't reroll a 10"
  end
  
  def test_successes_reroll
    suxx = @dr.successes(8, 9)
    
    assert suxx >= 2, "should have rolled more successes"
    assert @dr.ten_result.count >= 6, "didn't reroll a 9 or 10"
  end
  
  def test_successes_subtract
    suxx = @dr.successes(8, 10, true)
    
    assert suxx >= 0, "should have rolled more successes"
    assert @dr.ten_result.count >= 5, "didn't reroll a 10"
  end
  
  def test_successes_rote
    suxx = @dr.successes(8, 0)
    
    assert suxx >= 2, "should have rolled more successes"
    assert @dr.ten_result.count >= 7, "didn't reroll per rote action"
  end
end
