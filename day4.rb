test_input = File.read("../day4.txt")
example = <<TXT
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
TXT

# finally just writing the maze class I always need for AoC
class Maze2D
  EMPTY_SPACE = '.'
  CLEARED_SPACE = 'x'

  def initialize(input)
    @maze = input.split("\n").map { |row| row.split("") }
    @max_row = @maze.length
    @max_col = @maze.first.length
  end

  def each_cell
    (0...@max_row).each do |row|
      (0...@max_col).each do |col|
        yield [@maze[row][col], row, col]
      end
    end
  end

  def clear_cell(row, col)
    raise "Can't clear #{row}, #{col} - out of bounds!" if out_of_bounds?(row, col)
    @maze[row][col] = CLEARED_SPACE
  end


  def safe_access(row, col)
    return nil if out_of_bounds?(row, col)
    return @maze[row][col]
  end
  
  def out_of_bounds?(row, col)
    row < 0 || row >= @max_col || col < 0 || col >= @max_col
  end 

  def adjacent_values(row, col)
    [
      safe_access(row-1, col-1), 
      safe_access(row-1, col), 
      safe_access(row-1, col+1),
      safe_access(row, col-1),
      safe_access(row, col+1),
      safe_access(row+1, col-1),
      safe_access(row+1, col),
      safe_access(row+1, col+1)
    ].compact
  end
end

def part1(input)
  maze = Maze2D.new(input)
  count = 0
  maze.each_cell do |cell, row, col|
    next if cell != '@'
    
    neighbor_count = maze.adjacent_values(row, col).count { |c| c == '@' }
    count += 1 if neighbor_count < 4
  end

  count
end

def part2(input)
  # update the initial map by removing the accessible rolls
  maze = Maze2D.new(input)
  removable_rolls = []
  removed_total = 0

  loop do 
    maze.each_cell do |cell, row, col|
      next if cell != '@'
      
      neighbor_count = maze.adjacent_values(row, col).count { |c| c == '@' }
      removable_rolls << [row, col] if neighbor_count < 4
    end
    break if removable_rolls.empty?

    removable_rolls.each do |row, col|
      maze.clear_cell(row, col)
      removed_total += 1
    end
    puts "Removed #{removable_rolls.count} rolls, total removed is #{removed_total}"
    removable_rolls = []
  end

  removed_total
end

puts "Part 1"
p part1(example)
p part1(test_input)

puts "Part 2"
p part2(example)
p part2(test_input)