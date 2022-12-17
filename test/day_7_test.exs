defmodule Aoc2022Test.Day7 do
  use ExUnit.Case

  test "test day 7 part 1" do
    assert Day7.part_1("input/test_cases/day7.txt") == 95437
  end

  test "test day 7 part 2" do
    assert Day7.part_2("input/test_cases/day7.txt") == 24933642
  end
end
