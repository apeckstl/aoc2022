defmodule Day8 do
  def part_1(file_path) do
    rows =
      file_path
      |> FileHelpers.Reader.read_file()
      |> Enum.map(&String.split(&1, "", trim: true))

    columns =
      file_path
      |> FileHelpers.Reader.read_file_as_columns()

    grid_size = Enum.count(rows)

    {total_visible, _} = Enum.reduce(rows, {0, 0}, fn row, {current_total, idx} ->

      {total_for_row, _} = Enum.reduce(row, {0, 0}, fn item, {t, t_idx} ->
        if idx == 0 or t_idx == 0 or idx == grid_size - 1 or t_idx == grid_size - 1 do
          {t + 1, t_idx + 1}
        else
          column = Enum.at(columns, t_idx)
          is_hidden_above = Enum.any?(Enum.slice(column, 0..idx-1), fn el ->
            String.to_integer(el) >= String.to_integer(item)
          end)

          is_hidden_below = Enum.any?(Enum.slice(column, idx+1..Enum.count(column)-1), fn el ->
            String.to_integer(el) >= String.to_integer(item)
          end)

          is_hidden_to_left = Enum.any?(Enum.slice(row, 0..t_idx-1), fn el ->
            String.to_integer(el) >= String.to_integer(item)
          end)

          is_hidden_to_right = Enum.any?(Enum.slice(row, t_idx+1..Enum.count(row)-1), fn el ->
            String.to_integer(el) >= String.to_integer(item)
          end)

          if not is_hidden_above or not is_hidden_below or not is_hidden_to_left or not is_hidden_to_right do
            {t + 1, t_idx + 1}
          else
            {t, t_idx + 1}
          end
        end
      end)

      {current_total + total_for_row, idx + 1}
    end)
    total_visible
  end

  def part_2(file_path) do
    rows =
      file_path
      |> FileHelpers.Reader.read_file()
      |> Enum.map(&String.split(&1, "", trim: true))
      |> Enum.map(fn row -> Enum.map(row, &String.to_integer/1) end)

    columns =
      file_path
      |> FileHelpers.Reader.read_file_as_columns()
      |> Enum.map(fn col -> Enum.map(col, &String.to_integer/1) end)

    %{max: max} = Enum.reduce(rows, %{max: 0, row_idx: 0}, &reduce_row(&1, &2, rows, columns))
    max
  end

  defp reduce_row(row, %{max: current_max, row_idx: row_idx}, rows, columns) do
    {new_max, _} = Enum.reduce(row, {current_max, 0}, fn (element, {before_max, col_idx}) ->
      # need to calculate the viewing distance in each direction for this tree
      above =
        columns
        |> Enum.at(col_idx)
        |> Enum.slice(0..row_idx)
        |> Enum.drop(-1)
        |> Enum.reverse()
        |> get_viewing_distance(element)

      left =
        rows
        |> Enum.at(row_idx)
        |> Enum.slice(0..col_idx)
        |> Enum.drop(-1)
        |> Enum.reverse()
        |> get_viewing_distance(element)

      below =
        columns
        |> Enum.at(col_idx)
        |> Enum.slice(row_idx..-1)
        |> Enum.drop(1)
        |> get_viewing_distance(element)

      right =
        rows
        |> Enum.at(row_idx)
        |> Enum.slice(col_idx..-1)
        |> Enum.drop(1)
        |> get_viewing_distance(element)

      scenic_value = above * left * below * right

      if scenic_value > before_max do
        {scenic_value, col_idx + 1}
      else
        {before_max, col_idx + 1}
      end
    end)

    %{max: new_max, row_idx: row_idx + 1}
  end

  defp get_viewing_distance(slice, element) do
    Enum.reduce_while(slice, 0, fn (tree, acc) ->
      if tree < element do
        {:cont, acc + 1}
      else
        {:halt, acc + 1}
      end
    end)
  end

end
