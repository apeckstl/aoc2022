defmodule Day7 do
  def part_1(file_path) do
    written_history = FileHelpers.Reader.read_file(file_path)

    input = Enum.chunk_while(written_history, [], &chunk_function/2, &after_chunk_function/1)

    %{file_system: file_system} =
      input
      |> Enum.reduce(%{breadcrumbs: [], file_system: nil}, &process_group/2)

    {_directory_total, totals} = get_directory_total(file_system, [])

    totals
    |> Enum.reduce(0, fn total, sum -> if total <= 100000 do sum + total else sum end end)

  end

  def part_2(file_path) do
    written_history = FileHelpers.Reader.read_file(file_path)

    input = Enum.chunk_while(written_history, [], &chunk_function/2, &after_chunk_function/1)

    %{file_system: file_system} =
      input
      |> Enum.reduce(%{breadcrumbs: [], file_system: nil}, &process_group/2)

    {file_system_total, totals} = get_directory_total(file_system, [])
    unused_space = 70_000_000 - file_system_total

    need_deleted_space = 30_000_000 - unused_space

    totals
    |> Enum.reduce(file_system_total, fn candidate, current ->
      if candidate >= need_deleted_space and candidate < current do
        candidate
      else
        current
      end
    end)

  end

  defp chunk_function(element, []) do
    {:cont, [element]}
  end

  defp chunk_function(element, chunk) do
    if String.starts_with?(element, "$ cd") do
      {:cont, chunk, [element]}
    else
      {:cont, List.insert_at(chunk, -1, element)}
    end
  end

  defp after_chunk_function(chunk) do
    {:cont, chunk, []}
  end

  # We know this is a cd .. command
  defp process_group([_cd_command], %{breadcrumbs: [_ | breadcrumbs], file_system: file_system}) do
    %{breadcrumbs: breadcrumbs, file_system: file_system}
  end

  defp process_group([cd_command, _ls_command | group], %{breadcrumbs: breadcrumbs, file_system: file_system}) do
    [dir_name] = Regex.run(~r/\$ cd (.*)/, cd_command, capture: :all_but_first)
    if dir_name == "/" do
      update_file_system(dir_name, file_system, group, breadcrumbs)
    else
      update_file_system(dir_name, file_system, group, [dir_name | breadcrumbs])
    end

  end

  defp update_file_system(dir_name, directory, group, breadcrumbs) do
    if Enum.count(breadcrumbs) == 0 do
      directory_contents =
        group
        |> Enum.map(fn child ->
          if String.starts_with?(child, "dir") do
            name =
              child
              |> String.split()
              |> Enum.fetch!(1)

            %Directory{name: name}
          else
            [amount] =
              Regex.run(~r/([0-9]*) .*/, child, capture: :all_but_first)
            String.to_integer(amount)
          end
        end)
      %{breadcrumbs: breadcrumbs, file_system: %Directory{name: dir_name, children: directory_contents}}
    else # replace the correct directory in this directory with an updated one
      idx = Enum.find_index(directory.children, fn element ->
        case element do
          %Directory{name: name} -> name == List.last(breadcrumbs)
          _ -> false
        end
      end)

      el = Enum.at(directory.children, idx)
      %{breadcrumbs: _, file_system: updated_el} = update_file_system(dir_name, el, group, Enum.take(breadcrumbs, Enum.count(breadcrumbs) - 1))
      %{breadcrumbs: breadcrumbs, file_system: %{directory | children: List.replace_at(directory.children, idx, updated_el)}}
    end
  end

  defp get_directory_total(directory, directory_totals) do
    {total, current_directory_totals} =
      Enum.reduce(directory.children, {0, directory_totals}, fn child, {total, directory_totals} ->
        if is_integer(child) do
          {total + child, directory_totals}
        else
          {child_total, updated_directory_totals} = get_directory_total(child, directory_totals)
          {total + child_total, updated_directory_totals}
        end
    end)

    {total, [total | current_directory_totals]}
  end
end
