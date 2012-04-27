require 'test/unit'
require 'dice_roller'

class DiceTest < Test::Unit::TestCase
  def setup
    @d = DiceRoller::Dice.new(4)
  end

  def test_can_read_face
    @d.roll

    assert_equal @d.faces, 4, "couldn't read faces"
    assert_not_nil @d.value, "couldn't read rolled value"
  end

  def test_cant_write_value
    assert_raise NoMethodError do
      @d.value = 4
    end
  end

  def test_can_write_attributes
    @d.faces = 8

    assert_equal @d.faces, 8, "couldn't change the number of faces"
  end

  def test_roll
    assert_equal DiceRoller::Dice.new(4).roll.class, Fixnum, "rolling a dice did not return a Fixnum"
  end
end
