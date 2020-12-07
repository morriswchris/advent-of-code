INPUT = "./input.txt"

def part1
  group_totals = 0
  question_counts = {}
  IO.foreach(INPUT) do |line|
    line.strip!
    if line.empty?
      group_totals += question_counts.values.reduce(:+)
      question_counts = {}
    else
      tokens = line.split("")
      tokens.each do |token|
        question_counts[token] = 1 unless question_counts.key?(token)
      end
    end
  end
  group_totals += question_counts.values.reduce(:+)
  group_totals
end

def part2
  group_totals = 0
  question_counts = nil
  IO.foreach(INPUT) do |line|
    line.strip!
    if line.empty?
      group_totals += question_counts.size
      question_counts = nil
    elsif question_counts.nil?
      question_counts = line.split("")
    else
      question_counts = line.split("") & question_counts
    end
  end
  group_totals += question_counts.size
  group_totals
end

puts "part1: #{part1}"
puts "part2: #{part2}"
