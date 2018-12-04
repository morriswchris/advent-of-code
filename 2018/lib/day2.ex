"""
--- Day 2: Inventory Management System ---
You stop falling through time, catch your breath, and check the screen on the device. "Destination reached. Current Year: 1518. Current Location: North Pole Utility Closet 83N10." You made it! Now, to find those anomalies.

Outside the utility closet, you hear footsteps and a voice. "...I'm not sure either. But now that so many people have chimneys, maybe he could sneak in that way?" Another voice responds, "Actually, we've been working on a new kind of suit that would let him fit through tight spaces like that. But, I heard that a few days ago, they lost the prototype fabric, the design plans, everything! Nobody on the team can even seem to remember important details of the project!"

"Wouldn't they have had enough fabric to fill several boxes in the warehouse? They'd be stored together, so the box IDs should be similar. Too bad it would take forever to search the warehouse for two similar box IDs..." They walk too far away to hear any more.

Late at night, you sneak to the warehouse - who knows what kinds of paradoxes you could cause if you were discovered - and use your fancy wrist device to quickly scan every box and produce a list of the likely candidates (your puzzle input).

To make sure you didn't miss any, you scan the likely candidate boxes again, counting the number that have an ID containing exactly two of any letter and then separately counting those with exactly three of any letter. You can multiply those two counts together to get a rudimentary checksum and compare it to what your device predicts.

For example, if you see the following box IDs:

abcdef contains no letters that appear exactly two or three times.
bababc contains two a and three b, so it counts for both.
abbcde contains two b, but no letter appears exactly three times.
abcccd contains three c, but no letter appears exactly two times.
aabcdd contains two a and two d, but it only counts once.
abcdee contains two e.
ababab contains three a and three b, but it only counts once.
Of these box IDs, four of them contain a letter which appears exactly twice, and three of them contain a letter which appears exactly three times. Multiplying these together produces a checksum of 4 * 3 = 12.

What is the checksum for your list of box IDs?
"""
defmodule Day2 do
  def file do
    {twos, threes} = File.open!("assets/day2.txt")
    |> IO.stream(:line)
    |> Enum.map(&String.strip/1)
    |> Enum.map(&parse/1)
    |> Enum.reduce({0,0}, &sum/2)
    IO.inspect twos
    IO.inspect threes
    twos * threes
  end

  def sum({two, three}, {twos, threes}) do
    {twos + two, threes + three}
  end

  def parse(string) do
    string
    |> String.graphemes
    |> Enum.reduce({[], %{}}, &count_letter/2)
    |> elem(1)
    |> Map.to_list
    |> Enum.reduce_while({0,0}, &add/2)

  end
  
  def add({letter, 2}, {twos, threes}) do
    if !(threes == 1), do: {:cont, {1, threes}}, else: {:halt, {1, threes}}
  end

  def add({letter, 3}, {twos, threes}) do
    if !(twos == 1), do: {:cont, {twos, 1}}, else: {:halt, {twos, 1}}
  end
  
  def add({_, _}, {twos, threes}) do
    {:cont, {twos, threes}}
  end

  def count_letter(letter, {graphemes, seen}) do
    count = graphemes ++ [letter]
    |> Enum.count(& &1 == letter)

    {graphemes ++ [letter],  Map.put(seen, letter, count)}
  end
end

