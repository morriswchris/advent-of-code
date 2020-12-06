INPUT = "./input.txt"
TOTAL_ROWS = (0..127).to_a
TOTAL_COLUMNS = (0..7).to_a

def calculate_seat(seat)
  tokens = seat.split("")
  rows = tokens.first(7)
  seats = tokens.last(3)
  row_array = rows.reduce(TOTAL_ROWS) do |acc, row|
    if row == "F"
      acc[0...acc.size/2]
    else
      acc[acc.size/2..-1]
    end
  end
  column_array = seats.reduce(TOTAL_COLUMNS) do |acc, row|
    if row == "L"
      acc[0...acc.size/2]
    else
      acc[acc.size/2..-1]
    end
  end

  row = row_array.first
  col = column_array.first

  (row * 8) + col
end

def part1
  max = 0
  IO.foreach(INPUT) do |line|
    seat = calculate_seat(line.strip)
    max = seat if seat > max
  end
  max
end

def part2
  all_seats = (0..892).to_a
  seats = []
  IO.foreach(INPUT) do |line|
    seats.push(calculate_seat(line.strip))
  end
  (all_seats - seats).last
end

puts "part1: #{part1}"
puts "part2: #{part2}"
