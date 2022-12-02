defmodule Aoc2022Test.Day1 do
  use ExUnit.Case
  doctest Day1

  test "test day 2 part 1" do
    assert Day2.part_1("input/test_cases/day2.txt") == 15
  end

  test "test day 2 part 2" do
    assert Day2.part_2("input/test_cases/day2.txt") == 12
  end
end
