require_relative "position_policy"
require_relative "range_policy"

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
