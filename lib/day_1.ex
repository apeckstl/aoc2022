defmodule Day1 do
  def part_1(file_path) do
    elf_lists = FileHelpers.Reader.read_file(file_path, delimiter: "\n\n")

    arrays =
      Enum.map(elf_lists, fn list ->
        list
        |> String.split("\n")
        |> Enum.map(&String.to_integer/1)
      end)

    Enum.reduce(arrays, 0, fn elf_list, highest ->
      if Enum.sum(elf_list) > highest do
        Enum.sum(elf_list)
      else
        highest
      end
    end)
  end

  def part_2(file_path) do
    elf_lists = FileHelpers.Reader.read_file(file_path, delimiter: "\n\n")

    arrays =
      Enum.map(elf_lists, fn list ->
        list
        |> String.split("\n")
        |> Enum.map(&String.to_integer/1)
      end)

    %{first: elf1, second: elf2, third: elf3} =
      Enum.reduce(arrays, %{first: 0, second: 0, third: 0},
        fn elf_list, ranks = %{first: a, second: b, third: c} ->
          current = Enum.sum(elf_list)

          cond do
            current > a ->
              %{first: current, second: a, third: b}

            current > b ->
              %{first: a, second: current, third: b}

            current > c ->
              %{first: a, second: b, third: current}

            true ->
              ranks
          end
        end)

    elf1 + elf2 + elf3
  end
end
