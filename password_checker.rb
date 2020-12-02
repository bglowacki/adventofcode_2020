class RangePolicy
  attr_reader :required_char, :min, :max

  def initialize(policy_string:)
    min_max, @required_char = policy_string.split(" ")
    @min, @max = min_max.split("-").map(&:to_i)
  end

  def valid?(password:)
    password.
      split("").
      select { |char| char == required_char }.
      size.
      between?(min, max)
  end
end

class PositionPolicy
  def initialize(policy_string:)
    indexes, @required_char = policy_string.split(" ")
    @first_index, @second_index = indexes.split("-").map(&:to_i)
  end

  def valid?(password:)
    only_first_position_contains_char?(password) || only_second_position_contains_char?(password)
  end

  private

  def only_first_position_contains_char?(password)
    first_position_contains_char?(password) && !second_position_contains_char?(password)
  end

  def only_second_position_contains_char?(password)
    !first_position_contains_char?(password) && second_position_contains_char?(password)
  end

  def first_position_contains_char?(password)
    password[@first_index - 1] == @required_char
  end

  def second_position_contains_char?(password)
    password[@second_index - 1] == @required_char
  end
end

class PasswordChecker
  def initialize(policy:)
    @policy = policy
  end

  def valid?(policy_password_string)
    policy, password = policy_password_string.split(": ")
    range_policy = @policy.new(policy_string: policy)
    range_policy.valid?(password: password)
  end

  def count_correct_passwords(input:)
    input.select { |policy_password_string| valid?(policy_password_string) }.count
  end
end

checker = PasswordChecker.new(policy: RangePolicy)
pp checker.count_correct_passwords(input: File.readlines("password_input.txt"))

checker = PasswordChecker.new(policy: PositionPolicy)
pp checker.count_correct_passwords(input: File.readlines("password_input.txt"))
