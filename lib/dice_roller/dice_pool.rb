# A class representing a bunch of dice (many objects of class Dice).
# Rolling this die pool passes output to a buffer indicated by the die.
class DiceRoller::DicePool
  attr_accessor :four, :six, :eight, :ten, :twelve, :twenty, :percent

  # create a pool of Dice with different numbers of sides
  #
  # four: the number of four-sided dice in the pool
  # six: the number of six-sided dice in the pool
  # eight: the number of eight-sided dice in the pool
  # ten: the number of ten-sided dice in the pool
  # twelve: the number of twelve-sided dice in the pool
  # twenty: the number of twenty-sided dice in the pool
  # percent: the number of percentile (100-sided) dice in the pool
  def initialize(four = 0, six = 0, eight = 0, ten = 0, twelve = 0, twenty = 0, percent = 0)
    @four = four
    @six = six
    @eight = eight
    @ten = ten
    @twelve = twelve
    @twenty = twenty
    @percent = percent
  end

  # roll the dice in the pool, with options. by default, roll_pool returns
  # the numer of successes rolled
  #
  # success_value: on 10-sided dice, the minimum value to be considered a success
  # sum_num: instead of displaying successes, display the total value rolled on all dice
  # number_successes: instead of returning the sum total rolled, return the successes
  # one_cancels: 1s rolled on a d10 subtract from the total successes
  # roll_again: the number on a d10 that rolls another d10
  def roll_pool(success_value = 8, sum_num = false, number_successes = true, one_cancels = false, roll_again = 10, outbuffer = '')
    buffer = outbuffer
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

    four_side = Die.new(4, buffer)
    six_side = Die.new(6, buffer)
    eight_side = Die.new(8, buffer)
    ten_side = Die.new(10, buffer)
    twelve_side = Die.new(12, buffer)
    twenty_side = Die.new(20, buffer)
    percentile = Die.new(100, buffer)

    @four.times do
      sum_value += four_side.roll()
    end
    @six.times do
      sum_value += six_side.roll()
    end
    @eight.times do
      sum_value += eight_side.roll()
    end
    @ten.times do
      is_rote = rote

      while tmp = ten_side.roll()
        sum_value += tmp
        successes += 1 if tmp >= success_value
        rerolls += 1 if tmp >= roll_again
        if tmp <= 1
          ones += 1
          successes -= 1 if one_cancels
        end

        break unless number_successes
        if tmp >= roll_again
          next
        elsif is_rote and ( tmp < roll_again )
          is_rote = false
          rote_rerolls += 1
          next
        else
          break
        end
      end
    end
    @twelve.times do
      sum_value += twelve_side.roll()
    end
    @twenty.times do
      sum_value += twenty_side.roll()
    end
    @percent.times do
      sum_value += percentile.roll()
    end

    buffer = buffer << "Ones Rolled: #{ones}\n" if one_cancels and number_successes
    buffer = buffer << "Re-rolls: #{rerolls}\n" unless ((@four + @six + @eight + @twelve + @twenty + @percent) != 0) or sum_num
    buffer = buffer << "Rote Re-rolls: #{rote_rerolls}\n" if rote and ((@four + @six + @eight + @twelve + @twenty + @percent) == 0) and ! sum_num
    buffer = buffer << "Successes: #{successes}\n" if number_successes
    buffer = buffer << "Sum Value: #{sum_value}\n" if sum_num

    buffer
  end

  # overrides the inspect method to provide some useful output
  def inspect()
    puts "four-sided dice: #{@four}"
    puts "six-sided dice: #{@six}"
    puts "eight-sided dice: #{@eight}"
    puts "ten-sided dice: #{@ten}"
    puts "twelve-sided dice: #{@twelve}"
    puts "twenty-sided dice: #{@twenty}"
    puts "percentile dice: #{@percentile}"
  end
end
