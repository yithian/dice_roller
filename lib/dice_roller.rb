class DiceRoller
  def initialize()
    results = DicePool.new(0, 0, 0, 10, 0, 0, 0).roll_pool

    buffer = ""

    buffer << "Successes: #{results.successes}\n"
    buffer << "Sum Value: #{results.total}\n"
  end
end

require 'dice_roller/dice.rb'
require 'dice_roller/dice_pool.rb'
require 'dice_roller/dice_result.rb'
