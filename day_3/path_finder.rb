class PathFinder
  attr_reader :map

  def initialize(map)
    rows = map.split("\n")
    @map = rows.map { |row| row.split("") }
  end

  def number_of_collisions(slope)
    current_position = [0, 0]
    number_of_trees = 0
    map.each do
      number_of_trees += 1 if map[current_position[0]][current_position[1]] == "#"
      move_down(current_position, slope[0])
      move_right(current_position, slope[1])
      break if current_position[0] > map.size
    end
    number_of_trees
  end

  private

  def move_down(current_position, steps)
    steps.times.each do
      current_position[0] += 1
    end
  end

  def move_right(current_position, steps)
    steps.times.each do
      current_position[1] += 1
      current_position[1] = 0 if current_position[1] == map[0].size
    end
  end
end

# slopes = [
#   [1,3],
#   [1,1],
#   [1,5],
#   [1,7],
#   [2,1]
# ]
#
# @path_finder = PathFinder.new(File.read("input.txt"))
# collisions = slopes.map do |slope|
#   @path_finder.number_of_collisions(slope)
# end
# pp collisions.inject(:*)
