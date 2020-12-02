class Day1
  INPUT = "./input.txt"
  SUM = 2020

  def self.call
    # we need 2 numbers that sum to 2020, the best way of doing this is to:
    # * read the number
    # * do 2020 - number
    # * store this and when we see that nubmer return both
    seen = {}
    IO.foreach(INPUT) do |line|
      line = line.to_i
      diff = SUM - line
      return seen[line] * line if seen.key?(line)
      seen[diff] = line
    end
  end

  def self.call2
    # we need 3 numbers that sum to 2020, the best way of doing this is to:
    # * read the number
    # * do 2020 - number
    # * store this and re-run the diff calc with a new sum target
    lines = File.readlines(INPUT)
    lines.each do |line|
      seen = {}
      line = line.to_i
      diff = SUM - line
      product = nil
      lines.each do |line2|
        line2 = line2.to_i
        diff2 = diff - line2
        if seen.key?(line2)
          product = seen[line2] * line2
          break;
        end
        seen[diff2] = line2
      end
      return line * product if product
    end
  end
end
