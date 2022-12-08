defmodule Day6 do
  def part_1(file_path) do
    file_path
    |> FileHelpers.Reader.read_file(delimiter: "")
    |> Enum.chunk_every(4, 1)
    |> Enum.reduce_while(4, &check_marker/2)
  end

  def part_2(file_path) do
    file_path
    |> FileHelpers.Reader.read_file(delimiter: "")
    |> Enum.chunk_every(14, 1)
    |> Enum.reduce_while(14, &check_marker/2)
  end

  defp check_marker(window, count) do
    if Enum.uniq(window) == window do
      {:halt, count}
    else
      {:cont, count + 1}
    end
  end
end
