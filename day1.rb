# day1.rb

example = <<TXT.split("\n")
L68
L30
R48
L5
R360
L55
L1
L99
R14
L82
TXT

test = File.read('day1.txt').split("\n")

def part1(input)
  pos = 50
  zeroes = 0
  input.each do |rot|
    dir = rot[0]
    dist = rot[1..-1].to_i
    # puts "#{dir}: #{dist}"
    pos += dist * (dir == 'L' ? -1 : 1)
    pos = pos % 100
    zeroes += 1 if pos == 0
    # puts pos
  end
  zeroes
end

def part2(input)
  pos = 50
  zeroes = 0
  input.each do |rot|
    dir = rot[0]
    dist = rot[1..-1].to_i
    full_rotations, remainder = dist.divmod(100)
    zeroes += full_rotations
    new_pos = pos + (remainder * (dir == 'L' ? -1 : 1))
    #print "Move #{rot}: start at #{pos}, end at #{new_pos}, w/ #{full_rotations} full rotations"
    if new_pos % 100 == 0
      #print " & landed on 0\n"
      zeroes += 1
    elsif pos != 0 && dir == 'L' && new_pos < 0
      #print " & passed 0 CCW\n"
      zeroes += 1
    elsif pos != 0 && dir == 'R' && new_pos > 99
      #print " & passed 0 CW\n"
      zeroes += 1
    else
      #print "\n"
    end
    pos = new_pos % 100
  end
  zeroes
end

puts "Part 1"
puts part1(example)
puts part1(test)

puts "Part 2"
puts part2(example)
puts part2(test)