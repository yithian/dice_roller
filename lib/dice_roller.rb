# rolls dice and formats the results
class DiceRoller
  def initialize(four = 0, six = 0, eight = 0, ten = 0, twelve = 0, twenty = 0, percentile = 0, type = :sum, reroll = 10, minimum = 8, subtract = false)
    results = DicePool.new(four, six, eight, ten, twelve, twenty, percentile).roll_pool

    case type
    when :sum
      # output each dice's value and the sum total
      results.four_result.each do |value|
        puts "four-sided dice: #{value}"
      end
      
      results.six_result.each do |value|
        puts "six-sided dice: #{value}"
      end
      
      results.eight_result.each do |value|
        puts "eight-sided dice: #{value}"
      end
      
      results.ten_result.each do |value|
        puts "ten-sided dice: #{value}"
      end
      
      results.twelve_result.each do |value|
        puts "twelve-sided dice: #{value}"
      end
      
      results.twenty_result.each do |value|
        puts "twenty-sided dice: #{value}"
      end
      
      results.percentile_result.each do |value|
        puts "percentile dice: #{value}"
      end
      
      puts "sum total: #{results.total}"
    when :successes
      # output the ten-sided dice's values and the
      # number of successes
      suxx = results.successes(minimum, reroll, subtract)

      results.ten_result.each do |value|
        puts "ten-sided dice: #{value}"
      end

      puts "successes: #{suxx}"
    end
  end
end

require 'dice_roller/dice'
require 'dice_roller/dice_pool'
require 'dice_roller/dice_result'
require 'dice_roller/cli'
