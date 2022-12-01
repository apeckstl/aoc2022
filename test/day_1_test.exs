defmodule Aoc2022Test.Day1 do
  use ExUnit.Case
  doctest Day1

  test "test day 1 part 1" do
    assert Day1.part_1("input/test_cases/day1.txt") == 24000
  end

  test "test day 1 part 2" do
    assert Day1.part_2("input/test_cases/day1.txt") == 45000
  end
end
