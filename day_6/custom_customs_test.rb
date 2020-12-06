require "minitest/autorun"
require_relative "custom_customs"

class CustomCustomsTest < Minitest::Test
  def setup
    @input = <<~ANSWERS
      abc

      a
      b
      c

      ab
      ac

      a
      a
      a
      a

      b
    ANSWERS
  end

  def test_yes_answers
    assert_equal(11, CustomCustoms.count_yes_answers(input: @input))
  end
end

