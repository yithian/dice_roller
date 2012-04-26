# A class representing a single dice. Rolling this dice passes output to a buffer (string)
class DiceRoller::Dice
  attr_accessor :faces, :outbuffer

  # create a single dice
  #
  # faces: the number of sides on the dice
  # outbuffer: a string to contain pretty output
  def initialize(faces = 6, outbuffer = '')
    @faces = faces
    @outbuffer = outbuffer
  end

  # roll the dice, appending pretty output to its buffer
  # and returning the result
  def roll()
    tmp = rand(@faces) + 1
    @outbuffer = @outbuffer << "#{@faces}-sided die => #{tmp}\n"
    tmp
  end
end
