# A class representing a bunch of dice (many objects of class Dice).
# Rolling this die pool returns an object of the DiceResult class
class DiceRoller::DicePool
  attr_accessor :num_four, :num_six, :num_eight, :num_ten, :num_twelve, :num_twenty, :num_percent, :result

  # create a pool of Dice with different numbers of sides
  #
  # four: the number of four-sided dice in the pool
  # six: the number of six-sided dice in the pool
  # eight: the number of eight-sided dice in the pool
  # ten: the number of ten-sided dice in the pool
  # twelve: the number of twelve-sided dice in the pool
  # twenty: the number of twenty-sided dice in the pool
  # percent: the number of percentile (100-sided) dice in the pool
  def initialize(four = 0, six = 0, eight = 0, ten = 0, twelve = 0, twenty = 0, percentile = 0)
    @num_four = four
    @num_six = six
    @num_eight = eight
    @num_ten = ten
    @num_twelve = twelve
    @num_twenty = twenty
    @num_percentile = percentile

    @result = ::DiceRoller::DiceResult.new
  end

  # roll the dice in the pool, with options. by default, roll_pool returns
  # the numer of successes rolled
  #
  # success_value: on 10-sided dice, the minimum value to be considered a success
  # sum_num: instead of displaying successes, display the total value rolled on all dice
  # number_successes: instead of returning the sum total rolled, return the successes
  # one_cancels: 1s rolled on a d10 subtract from the total successes
  # roll_again: the number on a d10 above which another d10 should be rolled
  def roll_pool(success_value = 8, sum_num = false, number_successes = true, one_cancels = false, roll_again = 10)
    sum_value = 0
    successes = 0
    ones = 0
    rerolls = 0
    rote_rerolls = 0
    roll_again = roll_again.to_i
    rote = false

    if roll_again == 0
      roll_again = 10
      rote = true
    end

    # set up a single dice of each type and an array to store their results
    four_sided = ::DiceRoller::Dice.new(4)
    four_results = []

    six_sided = ::DiceRoller::Dice.new(6)
    six_results = []

    eight_sided = ::DiceRoller::Dice.new(8)
    eight_results = []

    ten_sided = ::DiceRoller::Dice.new(10)
    ten_results = []

    twelve_sided = ::DiceRoller::Dice.new(12)
    twelve_results = []

    twenty_sided = ::DiceRoller::Dice.new(20)
    twenty_results =  []

    percentile = ::DiceRoller::Dice.new(100)
    percentile_results = []

    # roll dem bones!
    @num_four.times do
      four_results << four_sided.roll
    end
    @num_six.times do
      six_results << six_sided.roll
    end
    @num_eight.times do
      eight_results << eight_sided.roll
    end
    @num_ten.times do
      ten_results << ten_sided.roll
    end
    @num_twelve.times do
      twelve_sided << twelve_sided.roll
    end
    @num_twenty.times do
      twenty_results << twenty_sided.roll
    end
    @num_percentile.times do
      percentile_results << percentile.roll
    end

    ::DiceRoller::DiceResult.new(four_results, six_results, eight_results, ten_results, twelve_results, twenty_results, percentile_results)
  end

  # overrides the inspect method to provide some useful output
  def inspect()
    puts "four-sided dice: #{@num_four}"
    puts "six-sided dice: #{@num_six}"
    puts "eight-sided dice: #{@num_eight}"
    puts "ten-sided dice: #{@num_ten}"
    puts "twelve-sided dice: #{@num_twelve}"
    puts "twenty-sided dice: #{@num_twenty}"
    puts "percentile dice: #{@num_percentile}"
  end
end
