class CurrentPosition
  attr_reader :row, :column

  def initialize(row, column)
    @row = row
    @column = column
  end

  def move_right(steps, map_size)
    steps.times.each do
      @row += 1
      @row = 0 if @row == map_size
    end
  end

  def move_down(steps)
    steps.times.each do
      @column += 1
    end
  end
end


class PathFinder
  attr_reader :map

  def initialize(map)
    rows = map.split("\n")
    @map = rows.map { |row| row.split("") }
  end

  def number_of_collisions(slope)
    current_position = CurrentPosition.new(0, 0)
    number_of_trees = 0
    map.each do
      number_of_trees += 1 if map[current_position.column][current_position.row] == "#"
      current_position.move_down(slope[0])
      current_position.move_right(slope[1], map[0].size)
      break if current_position.column > map.size
    end
    number_of_trees
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
