class SeatFinder
  def initialize
    @all_rows = (0..127).to_a
    @all_columns = (0..7).to_a
    @current_row_section = @all_rows
    @current_column_section = @all_columns
  end

  def find_seat(seat_code)
    seat_code.split("").first(7).each do |code|
      @current_row_section = find_nex_section(code, @current_row_section)
    end

    seat_code.split("").last(3).each do |code|
      @current_column_section = find_nex_section(code, @current_column_section)
    end

    [@current_row_section.first, @current_column_section.first, (@current_row_section.first * 8 + @current_column_section.first)]
  end

  def find_nex_section(code, current_section)
    divided_section = current_section.each_slice(current_section.size / 2).to_a
    if code == "F" || code == "L"
      divided_section[0]
    else
      divided_section[1]
    end
  end
end

ids = File.readlines("input.txt").map do |code|
  seat_finder = SeatFinder.new
  seat_finder.find_seat(code.strip)[2]
end.sort

ids.sort.each_with_index do |id, index|
  if id - 1  != ids[index - 1]
    pp id
  end
end
