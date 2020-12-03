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
    slope = Slope.new([1,3])
    assert_equal(7, @path_finder.find_number_of_tree_collisions(slope))
  end

  def test_find_number_of_trees_slope_1_down_1_right
    @path_finder = PathFinder.new(@map)
    slope = Slope.new([1,1])
    assert_equal(2, @path_finder.find_number_of_tree_collisions(slope))
  end

  def test_find_number_of_trees_slope_1_down_5_right
    @path_finder = PathFinder.new(@map)
    slope = Slope.new([1,5])
    assert_equal(3, @path_finder.find_number_of_tree_collisions(slope))
  end

  def test_find_number_of_trees_slope_1_down_7_right
    @path_finder = PathFinder.new(@map)
    slope = Slope.new([1,7])
    assert_equal(4, @path_finder.find_number_of_tree_collisions(slope))
  end

  def test_find_number_of_trees_slope_2_down_1_right
    @path_finder = PathFinder.new(@map)
    slope = Slope.new([2,1])
    assert_equal(2, @path_finder.find_number_of_tree_collisions(slope))
  end
end
