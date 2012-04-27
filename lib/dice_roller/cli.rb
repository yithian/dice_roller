require 'optparse'

# this class handles parsing the command-line options
# and calling the appropriate actions
class DiceRoller::Cli
  def initialize(args)
    # default the number of each type of dice to zero
    four = six = eight = ten = twelve = twenty = percentile = 0
    
    # default result set to sum
    type = :sum
    
    opts = OptionParser.new do |opts|
      opts.banner = "Usage: dice-roller"
      
      opts.on("--four dice", Integer, "number of four-sided dice to roll") do |dice|
        four = dice
      end
      
      opts.on("--six dice", Integer, "number of six-sided dice to roll") do |dice|
        six = dice
      end
      
      opts.on("--eight dice", Integer, "number of eight-sided dice to roll") do |dice|
        eight = dice
      end
      
      opts.on("--ten dice", Integer, "number of ten-sided dice to roll") do |dice|
        ten = dice
      end
      
      opts.on("--twelve dice", Integer, "number of twelve-sided dice to roll") do |dice|
        twelve = dice
      end
      
      opts.on("--twenty dice", Integer, "number of twenty-sided dice to roll") do |dice|
        twenty = dice
      end
      
      opts.on("--percentile dice", Integer, "number of percentile dice to roll") do |dice|
        percentile = dice
      end
      
      opts.on("--type TYPE", [:sum, :successes], "select type of result (sum, successes)") do |t|
        type = t
      end
    end
    
    opts.parse!(args)
    
    ::DiceRoller.new(four, six, eight, ten, twelve, twenty, percentile, type)
  end
end