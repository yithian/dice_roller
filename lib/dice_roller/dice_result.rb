# represents a result set from rolled dice
# it takes a series of arrays as input -- these arrays
# should contain the results of dice rolls
class DiceRoller::DiceResult
  attr_reader :four_result, :six_result, :eight_result, :ten_result, :twelve_result, :twenty_result, :percentile_result

  def initialize(four = [], six = [], eight = [], ten = [], twelve = [], twenty = [], percentile = [])
    @four_result = four
    @six_result = six
    @eight_result = eight
    @ten_result = ten
    @twelve_result = twelve
    @twenty_result = twenty
    @percentile_result = percentile
    @rerolled = false
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

  # returns a hash with the number of successes (as determined by the paremeters)
  # and the results of all the dice rolled
  #
  # min: minimum value for a success
  # reroll: minimum value to roll an additional d10
  # subtract: if true, causes values of 1 to subtract from the success total
  def successes(min = 8, reroll = 10, subtract = false)
    count = 0
    rote = false

    # if this result set has already been rerolled, simply count the successes
    # in the result and return the total (rather than rerolling /again/)
    if @rerolled
      @ten_result.each do |value|
        count += 1 if value >= min
      end

      return count
    end

    if reroll == 0
      reroll = 10
      rote = true
    end

    # this bonus dice is used for any rerolls that accrue
    bonus_dice = ::DiceRoller::Dice.new(sides = 10)

    # reroll failed dice once and add the results to the array
    if rote
      rote_rerolls = []

      @ten_result.each do |result|
        rote_rerolls << bonus_dice.roll if result < min
      end

      @ten_result += rote_rerolls
    end

    # loop through the rolled results and count successes. values greater than
    # the reroll value are rolled again.
    final_result = []

    @ten_result.each do |dice|
      this_dice = [dice]

      this_dice.each do |result|
        count += 1 if result >= min
        count -= 1 if subtract and result == 1

        # each pass through this loop is a rerolled dice
        if result >= reroll
          bonus_result = bonus_dice.roll

          # add the reroll result to the current dice's results, this will
          # reroll as appropriate
          this_dice << bonus_result
        end
      end

      final_result += this_dice
    end

    @ten_result = final_result
    @rerolled = true
    count
  end
end
