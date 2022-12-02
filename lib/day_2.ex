defmodule Day2 do
  @win_states [%{me: "X", opp: "C"}, %{me: "Y", opp: "A"}, %{me: "Z", opp: "B"}]
  @tie_states [%{me: "X", opp: "A"}, %{me: "Y", opp: "B"}, %{me: "Z", opp: "C"}]
  @lose_states [%{me: "X", opp: "B"}, %{me: "Y", opp: "C"}, %{me: "Z", opp: "A"}]

  @shape_points [X: 1, Y: 2, Z: 3]


  def part_1(file_path) do
    rounds =
      file_path
      |> FileHelpers.Reader.read_file()
      |> Enum.map(fn line -> String.split(line) end)
      |> Enum.map(fn [opp, me] -> %{opp: opp, me: me} end)

    Enum.reduce(rounds, 0, fn round, acc -> acc + score_round_1(round) end)
  end

  def part_2(file_path) do
    rounds =
      file_path
      |> FileHelpers.Reader.read_file()
      |> Enum.map(fn line -> String.split(line) end)
      |> Enum.map(fn [opp, outcome] -> %{opp: opp, outcome: outcome} end)

    Enum.reduce(rounds, 0, fn round, acc -> acc + score_round_2(round) end)
  end

  @spec score_round_1(map) :: integer
  defp score_round_1(round = %{me: me}) do
    outcome_points =
      cond do
        round in @win_states ->
          6
        round in @tie_states ->
          3
        true ->
          0
      end

    outcome_points + @shape_points[String.to_atom(me)]
  end

  @spec score_round_2(map) :: integer
  defp score_round_2(%{outcome: outcome, opp: opp}) do
    cond do
      outcome == "X" ->
        %{me: me} = Enum.find(@lose_states, fn %{opp: move} -> move == opp end)
        0 + @shape_points[String.to_atom(me)]

      outcome == "Y" ->
        %{me: me} = Enum.find(@tie_states, fn %{opp: move} -> move == opp end)
        3 + @shape_points[String.to_atom(me)]

      outcome == "Z" ->
        %{me: me} = Enum.find(@win_states, fn %{opp: move} -> move == opp end)
        6 + @shape_points[String.to_atom(me)]
    end
  end
end
