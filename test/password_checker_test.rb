require 'minitest/autorun'
require_relative  "../password_checker"

class PasswordCheckerTest < Minitest::Test
  def test_when_range_policy
    @valid_1 = "1-3 a: abcde"
    @valid_2 = "2-9 c: ccccccccc"
    @invalid_1 = "1-3 b: cdefg"
    @invalid_2 = "3-4 c: cdefg"

    password_checker  = PasswordChecker.new(policy: RangePolicy)

    assert(password_checker.valid?(@valid_1))
    assert(password_checker.valid?(@valid_2))
    refute(password_checker.valid?(@invalid_1))
    refute(password_checker.valid?(@invalid_2))
  end

  def test_when_position_policy
    @valid_1 = "1-3 a: abcde"
    @invalid_1 = "2-9 c: ccccccccc"
    @invalid_2 = "3-4 c: cdefg"

    password_checker  = PasswordChecker.new(policy: PositionPolicy)

    assert(password_checker.valid?(@valid_1))
    refute(password_checker.valid?(@invalid_1))
    refute(password_checker.valid?(@invalid_2))
  end
end
