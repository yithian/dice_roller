require 'test/unit'
require 'dice_roller'

class DicePoolTest < Test::Unit::TestCase
  def setup
    @dp = DiceRoller::DicePool.new(1, 2, 3, 4, 5, 6, 7)
  end

  def test_access_dice
    assert_equal @dp.num_four, 1, "read wrong number of four-sided dice"
    assert_equal @dp.num_six, 2, "read wrong number of six-sided dice"
    assert_equal @dp.num_eight, 3, "read wrong number of eight-sided dice"
    assert_equal @dp.num_ten, 4, "read wrong number of ten-sided dice"
    assert_equal @dp.num_twelve, 5, "read wrong number of twelve-sided dice"
    assert_equal @dp.num_twenty, 6, "read wrong number of twenty-sided dice"
    assert_equal @dp.num_percentile, 7, "read wrong number of percentile dice"

    assert @dp.num_four = 2, "couldn't change number of four-sided dice"
    assert @dp.num_six = 2, "couldn't change number of six-sided dice"
    assert @dp.num_eight = 2, "couldn't change number of eight-sided dice"
    assert @dp.num_ten = 2, "couldn't change number of ten-sided dice"
    assert @dp.num_twelve = 2, "couldn't change number of twelve-sided dice"
    assert @dp.num_twenty = 2, "couldn't change number of twenty-sided dice"
    assert @dp.num_percentile = 2, "couldn't change number of percentile-sided dice"
  end

  def test_roll
    assert_equal @dp.roll_pool.class, DiceRoller::DiceResult, "rolling a dice pool did not return a dice result set"
  end
end
