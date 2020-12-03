class CurrentPosition
  attr_reader :row, :column

  def initialize(row, column)
    @row = row
    @column = column
  end

  def change(slope, map)
    move_right(slope.right, map)
    move_down(slope.down)
  end

  private

  def move_right(steps, map)
    steps.times.each do
      step_right
      move_to_left_edge if map.edge?(self)
    end
  end

  def move_down(steps)
    steps.times.each do
      step_down
    end
  end

  def step_down
    @row += 1
  end

  def step_right
    @column += 1
  end

  def move_to_left_edge
    @column = 0
  end
end

class Map
  def initialize(input)
    rows = input.split("\n")
    @grid = rows.map { |row| row.split("") }
  end

  def number_of_rows
    @grid.size
  end

  def number_of_columns
    @grid[0].size
  end

  def tree?(current_position)
    @grid[current_position.row][current_position.column] == "#"
  end

  def edge?(position)
    number_of_columns == position.column
  end

  def bottom?(position)
    position.row >= number_of_rows
  end
end

class Slope
  attr_reader :down, :right

  def initialize(raw_slope)
    @down = raw_slope[0]
    @right = raw_slope[1]
  end
end

class TreeCounter
  attr_reader :count

  def initialize
    @count = 0
  end

  def add
    @count += 1
  end
end

class PathFinder
  attr_reader :map

  def initialize(raw_map)
    @map = Map.new(raw_map)
  end

  def number_of_collisions(slope)
    current_position = CurrentPosition.new(0, 0)
    tree_counter = TreeCounter.new

    until map.bottom?(current_position) do
      tree_counter.add if map.tree?(current_position)
      current_position.change(slope, map)
    end

    tree_counter.count
  end
end

# slopes = [
#   Slope.new([1,3]),
#   Slope.new([1,1]),
#   Slope.new([1,5]),
#   Slope.new([1,7]),
#   Slope.new([2,1])
# ]
#
# @path_finder = PathFinder.new(File.read("input.txt"))
# collisions = slopes.map do |slope|
#   @path_finder.number_of_collisions(slope)
# end
# pp collisions.inject(:*)
