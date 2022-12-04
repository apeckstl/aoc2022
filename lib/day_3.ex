defmodule Day3 do

  def part_1(file_path) do
    file_path
    |> FileHelpers.Reader.read_file()
    |> Enum.map(&split_rucksack/1)
    |> Enum.map(&find_common_item/1)
    |> Enum.reduce(0, &priority/2)

  end

  def part_2(file_path) do
    file_path
    |> FileHelpers.Reader.read_file()
    |> Enum.chunk_every(3)
    |> Enum.map(&find_common_item/1)
    |> Enum.reduce(0, &priority/2)
  end

  defp split_rucksack(rucksack) do
    split_index = div(String.length(rucksack), 2)
    String.split_at(rucksack, split_index)
  end

  defp find_common_item([comp1, comp2, comp3]) do
    comp1_items = MapSet.new(String.graphemes(comp1))
    comp2_items = MapSet.new(String.graphemes(comp2))
    comp3_items = MapSet.new(String.graphemes(comp3))

    first_intersect = MapSet.intersection(comp1_items, comp2_items)
    MapSet.intersection(first_intersect, comp3_items)
    |> MapSet.to_list()
    |> List.first()
  end

  defp find_common_item({comp1, comp2}) do
    comp1_items = MapSet.new(String.graphemes(comp1))
    comp2_items = MapSet.new(String.graphemes(comp2))

    MapSet.intersection(comp1_items, comp2_items)
    |> MapSet.to_list()
    |> List.first()
  end

  defp priority(item, current_total) do
    <<v::utf8>> = item
    if v <= 90 and v >= 65 do
      current_total + (v - 38)
    else
      current_total + (v - 96)
    end

  end

end
