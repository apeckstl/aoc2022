defmodule Day5 do
  def part_1(file_path) do
    input =
      file_path
      |> FileHelpers.Reader.read_file(delimiter: "\n\n")
      |> List.first()

    num_columns =
      input
      |> String.split("\n")
      |> List.last()
      |> String.split()
      |> List.last()
      |> String.to_integer()

    columns = Map.new(1..num_columns, fn n -> {n, []} end)

    stacks =
      input
      |> String.split("\n")
      |> Enum.drop(-1)
      |> Enum.reduce(columns, &update_stacks/2)

    file_path
    |> FileHelpers.Reader.read_file()
    |> Enum.drop_while(fn line -> not String.starts_with?(line, "m") end)
    |> Enum.reduce(stacks, &run_instruction_9000/2)
    |> Map.values()
    |> Enum.reduce("", fn list, acc -> acc <> List.last(list) end)
  end

  def part_2(file_path) do
    input =
      file_path
      |> FileHelpers.Reader.read_file(delimiter: "\n\n")
      |> List.first()

    num_columns =
      input
      |> String.split("\n")
      |> List.last()
      |> String.split()
      |> List.last()
      |> String.to_integer()

    columns = Map.new(1..num_columns, fn n -> {n, []} end)

    stacks =
      input
      |> String.split("\n")
      |> Enum.drop(-1)
      |> Enum.reduce(columns, &update_stacks/2)

    file_path
    |> FileHelpers.Reader.read_file()
    |> Enum.drop_while(fn line -> not String.starts_with?(line, "m") end)
    |> Enum.reduce(stacks, &run_instruction_9001/2)
    |> Map.values()
    |> Enum.reduce("", fn list, acc -> acc <> List.last(list) end)
  end

  defp update_stacks(line, columns) do
    {_, updated_stacks} =
      line
      |> String.graphemes()
      |> Enum.chunk_every(3, 4)
      |> Enum.reduce({1, columns}, fn [_, char, _], {idx, on_columns} ->
        if char != " " do
          e = Map.get(on_columns, idx)
          {idx + 1, Map.put(on_columns, idx, [char | e])}
        else
          {idx + 1, on_columns}
        end
      end)

      updated_stacks
  end

  defp run_instruction_9000(instruction, stacks) do
    [num, from, to] = Regex.run(~r/move ([0-9]*) from ([0-9]*) to ([0-9]*)/, instruction, capture: :all_but_first)

    stack_to_pop = Map.get(stacks, String.to_integer(from))
    {remaining_from, popped} = Enum.split(stack_to_pop, String.to_integer(num) * -1)

    popped_stacks = Map.put(stacks, String.to_integer(from), remaining_from)

    stack_to_add = Map.get(stacks, String.to_integer(to))

    Map.put(popped_stacks, String.to_integer(to), Enum.concat(stack_to_add, Enum.reverse(popped)))
  end

  defp run_instruction_9001(instruction, stacks) do
    [num, from, to] = Regex.run(~r/move ([0-9]*) from ([0-9]*) to ([0-9]*)/, instruction, capture: :all_but_first)

    stack_to_pop = Map.get(stacks, String.to_integer(from))
    {remaining_from, popped} = Enum.split(stack_to_pop, String.to_integer(num) * -1)

    popped_stacks = Map.put(stacks, String.to_integer(from), remaining_from)

    stack_to_add = Map.get(stacks, String.to_integer(to))

    Map.put(popped_stacks, String.to_integer(to), Enum.concat(stack_to_add, popped))
  end
end
