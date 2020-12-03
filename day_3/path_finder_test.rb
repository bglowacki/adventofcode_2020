require "minitest/autorun"
require_relative "path_finder"

class PathFinderTest < Minitest::Test
  def setup
    @map = <<~STR
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
    STR
  end


  def test_find_number_of_trees_slope_1_down_3_right
    @path_finder = PathFinder.new(@map)
    assert_equal(7, @path_finder.number_of_collisions([1,3]))
  end

  def test_find_number_of_trees_slope_1_down_1_right
    @path_finder = PathFinder.new(@map)
    assert_equal(2, @path_finder.number_of_collisions([1,1]))
  end

  def test_find_number_of_trees_slope_1_down_5_right
    @path_finder = PathFinder.new(@map)
    assert_equal(3, @path_finder.number_of_collisions([1,5]))
  end

  def test_find_number_of_trees_slope_1_down_7_right
    @path_finder = PathFinder.new(@map)
    assert_equal(4, @path_finder.number_of_collisions([1,7]))
  end

  def test_find_number_of_trees_slope_2_down_1_right
    @path_finder = PathFinder.new(@map)
    assert_equal(2, @path_finder.number_of_collisions([2,1]))
  end
end
