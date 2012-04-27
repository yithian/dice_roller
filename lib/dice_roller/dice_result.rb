# represents a result set from rolled dice
# it takes a series of arrays as input -- these arrays
# should contain the results of dice rolls
class DiceRoller::DiceResult
  attr_accessor :four_result, :six_result, :eight_result, :ten_result, :twelve_result, :twenty_result, :percentile_result

  def initialize(four = [], six = [], eight = [], ten = [], twelve = [], twenty = [], percentile = [])
    @four_result = four
    @six_result = six
    @eight_result = eight
    @ten_result = ten
    @twelve_result = twelve
    @twenty_result = twenty
    @percentile_result = percentile
  end

  # returns the sum total of all values in the results
  def total
    sum = 0

    @four_result.each do |result|
      sum += result
    end
    @six_result.each do |result|
      sum += result
    end
    @eight_result.each do |result|
      sum += result
    end
    @ten_result.each do |result|
      sum += result
    end
    @twelve_result.each do |result|
      sum += result
    end
    @twenty_result.each do |result|
      sum += result
    end
    @percentile_result.each do |result|
      sum += result
    end

    sum
  end

  # returns the number of successes as determined by the paremeters
  #
  # min: minimum value for a success
  # reroll: minimum value to roll an additional d10
  # subtract: if true, causes values of 1 to subtract from the success total
  def successes(min = 8, reroll = 10, subtract = false)
    count = 0
    rote = false
    rote_rerolls = 0

    if reroll == 0
      reroll = 10
      rote = true
    end

    # this bonus dice is used for any rerolls that accrue
    bonus_dice = ::DiceRoller::Dice.new(sides = 10)

    # loop through the rolled results and count successes. values greater than
    # the reroll value are rolled again.
    @ten_result.each do |result|
      count += 1 if result >= min
      rote_rerolls += 1 if result < min and rote

      count -= 1 if subtract and result == 1

      # each pass through this loop is a rerolled dice
      while result >= reroll
        result = bonus_dice.roll
        @ten_result << result

        count += 1 if result >= min
      end
    end

    # rote rerolls are done separately because their failed rerolls would
    # be added into the results, which would then be rerolled again. bad.
    rote_rerolls.times do
      result = bonus_dice.roll
      @ten_result << result

      count += 1 if result >= min

      # each pass through this loop is a rerolled dice
      while result >= reroll
        result = tmp_dice.roll
        @ten_result << result

        count += 1 if result >= min
      end
    end

    count
  end
end
