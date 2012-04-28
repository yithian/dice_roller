require 'optparse'

# this class handles parsing the command-line options
# and calling the appropriate actions
class DiceRoller::Cli
  attr_reader :four, :six, :eight, :ten, :twelve, :twenty, :percentile, :type, :minimum, :reroll, :subtract
  
  def initialize(args)
    # default the number of each type of dice to zero
    @four = @six = @eight = @ten = @twelve = @twenty = @percentile = 0
    
    # default result set to sum
    @type = :sum

    # default minimum value for success to 8
    @minimum = 8

    # default reroll value to 10
    @reroll = 10

    # default to ones not subtracting successes
    @subtract = false
    
    options = OptionParser.new do |opts|
      opts.banner = "Usage: dice-roller"
      
      opts.on("--four dice", Integer, "number of four-sided dice to roll") do |dice|
        @four = dice
      end
      
      opts.on("--six dice", Integer, "number of six-sided dice to roll") do |dice|
        @six = dice
      end
      
      opts.on("--eight dice", Integer, "number of eight-sided dice to roll") do |dice|
        @eight = dice
      end
      
      opts.on("--ten dice", Integer, "number of ten-sided dice to roll") do |dice|
        @ten = dice
      end
      
      opts.on("--twelve dice", Integer, "number of twelve-sided dice to roll") do |dice|
        @twelve = dice
      end
      
      opts.on("--twenty dice", Integer, "number of twenty-sided dice to roll") do |dice|
        @twenty = dice
      end
      
      opts.on("--percentile dice", Integer, "number of percentile dice to roll") do |dice|
        @percentile = dice
      end
      
      opts.on("--type [sum|successes]", [:sum, :successes], "select type of result (sum, successes)") do |t|
        @type = t

        if @type.nil?
          puts opts
          exit
        end
      end

      opts.on("--reroll number", Integer, "rolling this or above rolls another ten-sided dice") do |val|
        @reroll = val
      end

      opts.on("--rote", "make this roll a rote action") do |flag|
        # DiceRoller::DicePool interprets a reroll value of 0 as a rote action
        @reroll = 0 if flag
      end

      opts.on("--min number", Integer, "minimum value to be considered a success") do |min|
        @minimum = min
      end

      opts.on("--[no-]sub", "cause ones to subtract from the success total") do |flag|
        @subtract = flag
      end
    end
    
    begin
      options.parse!(args)
    rescue OptionParser::MissingArgument => e
      puts "Missing argument"
      puts options
      exit
    rescue OptionParser::InvalidArgument => e
      puts "Invalid argument"
      puts options
      exit
    rescue OptionParser::InvalidOption => e
      puts "Invalid option"
      puts options
      exit
    end
    
    return if $TEST
    
    ::DiceRoller.new(@four, @six, @eight, @ten, @twelve, @twenty, @percentile, @type, @reroll, @minimum, @subtract)
  end
end
