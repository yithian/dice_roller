require 'test/unit'
require 'dice_roller'

class DicePoolTest < Test::Unit::TestCase
  def setup
    @dp = DiceRoller::DicePool.new(1, 2, 3, 4, 5, 6, 7)
  end

  def test_access_dice
    assert_equal 1, @dp.num_four, "read wrong number of four-sided dice"
    assert_equal 2, @dp.num_six, "read wrong number of six-sided dice"
    assert_equal 3, @dp.num_eight, "read wrong number of eight-sided dice"
    assert_equal 4, @dp.num_ten, "read wrong number of ten-sided dice"
    assert_equal 5, @dp.num_twelve, "read wrong number of twelve-sided dice"
    assert_equal 6, @dp.num_twenty, "read wrong number of twenty-sided dice"
    assert_equal 7, @dp.num_percentile, "read wrong number of percentile dice"

    assert @dp.num_four = 2, "couldn't change number of four-sided dice"
    assert @dp.num_six = 2, "couldn't change number of six-sided dice"
    assert @dp.num_eight = 2, "couldn't change number of eight-sided dice"
    assert @dp.num_ten = 2, "couldn't change number of ten-sided dice"
    assert @dp.num_twelve = 2, "couldn't change number of twelve-sided dice"
    assert @dp.num_twenty = 2, "couldn't change number of twenty-sided dice"
    assert @dp.num_percentile = 2, "couldn't change number of percentile-sided dice"
  end

  def test_roll
    assert_equal DiceRoller::DiceResult, @dp.roll_pool.class, "rolling a dice pool did not return a dice result set"
  end
end
