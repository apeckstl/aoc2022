defmodule Day4 do
  def part_1(file_path) do
    file_path
      |> FileHelpers.Reader.read_file()
      |> Enum.map(&String.split(&1, ","))
      |> Enum.map(&check_covers/1)
      |> Enum.reduce(0,
        fn is_overlapping?, acc ->
          if is_overlapping? do
            acc + 1
          else acc
        end
      end)
  end

  def part_2(file_path) do
    file_path
      |> FileHelpers.Reader.read_file()
      |> Enum.map(&String.split(&1, ","))
      |> Enum.map(&check_overlapping/1)
      |> Enum.reduce(0,
        fn is_overlapping?, acc ->
          if is_overlapping? do
            acc + 1
          else acc
        end
      end)
  end

  defp check_covers([elf1, elf2]) do
    [elf1_lower, elf1_upper] = String.split(elf1, "-") |> Enum.map(&String.to_integer/1)
    [elf2_lower, elf2_upper] = String.split(elf2, "-") |> Enum.map(&String.to_integer/1)

    (elf1_lower <= elf2_lower and elf1_upper >= elf2_upper) or (elf2_lower <= elf1_lower and elf2_upper >= elf1_upper)
  end

  defp check_overlapping([elf1, elf2]) do
    [elf1_lower, elf1_upper] = String.split(elf1, "-") |> Enum.map(&String.to_integer/1)
    [elf2_lower, elf2_upper] = String.split(elf2, "-") |> Enum.map(&String.to_integer/1)

    (elf1_upper >= elf2_lower and elf1_lower <= elf2_upper) or (elf2_upper >= elf1_lower and elf2_lower <= elf1_upper)
  end
end
