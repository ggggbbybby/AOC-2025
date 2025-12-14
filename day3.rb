require 'pry'
example = <<TXT.split("\n")
987654321111111
811111111111119
234234234234278
818181911112111
TXT

test_input = File.read("../day3.txt").split("\n")

def part1(input)
  input.map do |batteries|
    # find maximum 'joltage' by locating the largest 2 digit integer we can assemble
    # so find the largest int in the first N-1 digits, then the largest int in the subsequent digits
    max_jolt(batteries).to_i
  end.sum
end

def max_jolt(str)
  i = 0
  first_digit = nil
  second_digit = nil
  while i < str.length
    if first_digit.nil? || (str[i] > first_digit && i < str.length - 1)
      first_idx = i
      #puts "Assigning first_digit of #{str[i]}"
      first_digit = str[i]
      second_digit = nil
      i += 1
      next
    end
    
    if second_digit.nil? || str[i] > second_digit
      #puts "Assigning second digit of #{str[i]}"
      second_digit = str[i]
    end
    i += 1
  end
  first_digit + second_digit
end

def part2(input)
  input.map.with_index do |batteries, idx|
    # p [idx, batteries]
    p2joltage(batteries, 12).to_i
  end.sum
end

def p2joltage(str, length)

  # looking at all of the options is too slow, but maybe we can memoize
  # our target string looks like this (100 digits)
  # 5433332355353372756453622653442176834335623343626343236463374522272945534432336513564562366234336223
  recursiveJoltage(str, length)
end

@memory = Hash.new { |h, k| h[k] = {} }

def recursiveJoltage(str, length)
  return nil if str.length < length
   
  if length == 1 || str.length == 1
    return str.chars.sort.last
  end
  
  if @memory[str][length].nil?
    withHead = str[0] + recursiveJoltage(str[1..], length - 1)
    woHead = recursiveJoltage(str[1..], length)
    @memory[str][length] = [withHead, woHead].compact.max
  end
  @memory[str][length]

end


puts "Part 1"
#p max_jolt("987654321111111")
#p max_jolt("811111111111119")
#p max_jolt("234234234234278")
#p max_jolt("818181911112111")


#p part1(example)
#p part1(test_input)

puts "Part 2"
p p2joltage("987654321111111", 12) == "987654321111"
p p2joltage("811111111111119", 12) == "811111111119"
p p2joltage("234234234234278", 12) == "434234234278"
p p2joltage("818181911112111", 12) == "888911112111"
p part2(example)
p part2(test_input)