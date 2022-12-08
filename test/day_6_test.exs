defmodule Aoc2022Test.Day6 do
  use ExUnit.Case

  test "test day 6 part 1 1" do
    assert Day6.part_1("input/test_cases/day6_1.txt") == 5
  end

  test "test day 6 part 1 2" do
    assert Day6.part_1("input/test_cases/day6_2.txt") == 6
  end

  test "test day 6 part 1 3" do
    assert Day6.part_1("input/test_cases/day6_3.txt") == 10
  end

  test "test day 6 part 1 4" do
    assert Day6.part_1("input/test_cases/day6_4.txt") == 11
  end

  test "test day 6 part 2 1" do
    assert Day6.part_2("input/test_cases/day6_1.txt") == 23
  end

  test "test day 6 part 2 2" do
    assert Day6.part_2("input/test_cases/day6_2.txt") == 23
  end

  test "test day 6 part 2 3" do
    assert Day6.part_2("input/test_cases/day6_3.txt") == 29
  end

  test "test day 6 part 2 4" do
    assert Day6.part_2("input/test_cases/day6_4.txt") == 26
  end
end
