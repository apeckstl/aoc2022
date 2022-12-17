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

  end

end
