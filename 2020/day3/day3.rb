INPUT = "./input.txt"

def calculate_trajectory(scenarios)
  move = 0
  tree_counts = {}
  IO.foreach(INPUT) do |line|
    line = line.strip
    unless move == 0
      scenarios.each do |scenario|
        right, down = scenario
        next unless move % down == 0
        pos =  (move.to_f/down).ceil * right % line.size
        key = "#{right},#{down}"
        tree_counts[key] = 0 unless tree_counts[key]
        tree_counts[key] += 1 if line[pos] == "#"
      end
    end
    move += 1
  end
  tree_counts.values.inject(:*)
end

puts "answer1 #{calculate_trajectory([[3,1]])}"

scenarios = [
    [1, 1],
    [3, 1],
    [5, 1],
    [7, 1],
    [1, 2]
  ]
puts "answer2 #{calculate_trajectory(scenarios)}"
