class DiceRoller
  def initialize()
    puts DicePool.new(0, 0, 0, 1, 0, 0, 0).inspect
  end
end

require 'dice_roller/dice.rb'
require 'dice_roller/dice_pool.rb'
