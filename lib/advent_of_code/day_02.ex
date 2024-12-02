defmodule AdventOfCode.Day02 do
  def part1(input) do
    input
    |> parse_input()
    |> Enum.filter(&is_safe?/1)
    |> Enum.count()
  end

  def part2(input) do
    input
    |> parse_input()
    |> Enum.filter(fn row ->
      max_index = length(row) - 1

      0..max_index
      |> Enum.map(
        &(row
          |> List.delete_at(&1)
          |> is_safe?())
      )
      |> Enum.any?()
    end)
    |> Enum.count()
  end

  defp parse_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split(" ")
      |> Enum.map(&String.to_integer(&1))
    end)
  end

  defp is_safe?(list) do
    is_safe?(list, :asc) or is_safe?(list, :desc)
  end

  defp is_safe?([], _mode), do: false
  defp is_safe?([_], _mode), do: true

  defp is_safe?([a, b | tail], :asc) when a < b do
    dif = b - a
    dif > 0 and dif <= 3 and is_safe?([b | tail], :asc)
  end

  defp is_safe?([a, b | tail], :desc) when a > b do
    dif = a - b
    dif > 0 and dif <= 3 and is_safe?([b | tail], :desc)
  end

  defp is_safe?(_list, _mode), do: false
end
