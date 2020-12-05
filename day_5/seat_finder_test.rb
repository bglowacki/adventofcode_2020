require "minitest/autorun"
require_relative "seat_finder"
class SeatFinderTest < Minitest::Test
  def setup
    @seat_finder = SeatFinder.new
  end

  def test_1
    assert_equal([70, 7, 567], @seat_finder.find_seat("BFFFBBFRRR"))
  end

  def test_2
    assert_equal([14, 7, 119], @seat_finder.find_seat("FFFBBBFRRR"))
  end

  def test_3
    assert_equal([102, 4, 820], @seat_finder.find_seat("BBFFBBFRLL"))
  end

  def test_4
    assert_equal([102, 4, 820], @seat_finder.find_seat("BBFFBFBRRR"))
  end
end

