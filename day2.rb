example = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"
test_input = File.read('../day2.txt')

def part1(input)
  ranges = input.split(",").map { |r| r.split('-').map(&:to_i) }
  ranges.flat_map do |rstart, rend|
    (rstart .. rend).reject { |id| valid?(id.to_s) }
  end.sum
end

def valid?(id)
  half = id.length / 2
  id[0...half] != id[half..-1]
end

def part2(input)
  ranges = input.split(",").map { |r| r.split('-').map(&:to_i) }
  ranges.flat_map do |rstart, rend|
    (rstart .. rend).select { |id| allRepeats?(id.to_s) }
  end.sum
end

def allRepeats?(id)
  half = id.length / 2
  (0...half).any? do |idx|
    substr = id[0..idx]
    id.gsub(substr, '').empty?
  end
end

# puts "Part 1"
# p part1(example)
# p part1(test_input)

puts "Part 2"
p part2(example)
p part2(test_input)