# A class representing a single dice. Rolling this dice returns the result
class DiceRoller::Dice
  attr_accessor :faces
  attr_reader :value

  # create a single dice
  #
  # faces: the number of sides on the dice
  def initialize(faces = 6)
    @faces = faces
    @value = nil
  end

  # roll the dice, storing and returning the resuilt
  def roll()
    @value = rand(@faces) + 1
  end
end
