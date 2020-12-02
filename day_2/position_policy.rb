class PositionPolicy

  def initialize(policy_string:)
    positions, @required_char = policy_string.split(" ")
    @first_position, @second_position = positions.split("-").map(&:to_i)
  end

  def valid?(password:)
    only_first_position_contains_char?(password) || only_second_position_contains_char?(password)
  end

  private
  attr_reader :required_char, :first_position, :second_position


  def only_first_position_contains_char?(password)
    first_position_contains_char?(password) && !second_position_contains_char?(password)
  end

  def only_second_position_contains_char?(password)
    !first_position_contains_char?(password) && second_position_contains_char?(password)
  end

  def first_position_contains_char?(password)
    password[first_position - 1] == required_char
  end

  def second_position_contains_char?(password)
    password[second_position - 1] == required_char
  end
end
