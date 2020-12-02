
class Day2
  INPUT = "./input.txt"
  SUM = 2020

  def self.call
    correct = 0
    IO.foreach(INPUT) do |line|
      range, character, password= line.split(" ")
      character.gsub!(":", "")
      front, back = range.split("-")
      character_count = password.count(character)
      correct += 1 if character_count >=front.to_i && character_count <= back.to_i
    end
    correct
  end

  def self.call2
    correct = 0
    IO.foreach(INPUT) do |line|
      range, character, password = line.split(" ")
      password = password.split("")
      character.gsub!(":", "")
      front, back = range.split("-")
      next if password.at((front.to_i - 1)) == character && password.at((back.to_i - 1)) == character
      correct += 1 if password.at((front.to_i - 1)) == character || password.at((back.to_i - 1)) == character
    end
    correct
  end
end
