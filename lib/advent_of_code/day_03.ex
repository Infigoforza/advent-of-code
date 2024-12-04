defmodule AdventOfCode.Day03 do
  @regex ~r/mul\((\d{1,3}),(\d{1,3})\)/

  def part1(input) do
    input
    |> parse_input()
    |> Enum.map(&extract_mul(&1))
    |> Enum.sum()
  end

  # most be 107069718
  def part2(input) do
    input
    |> parse_mul_and_do_instructions()
    |> elem(1)
  end

  defp parse_mul_and_do_instructions(input) do
    regex = ~r/(mul\((\d{1,3}),(\d{1,3})\)|do\(\)|don'?t\(\))/

    regex
    |> Regex.scan(input)
    |> Enum.reduce({:do, 0}, fn
      ["do()", _], acc -> {:do, elem(acc, 1)}
      ["don't()", _], acc -> {:dont, elem(acc, 1)}
      _, {:dont, value} -> {:dont, value}
      [_, _, n1, n2], {_, value} -> {:do, value + String.to_integer(n1) * String.to_integer(n2)}
    end)
  end

  defp parse_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
  end

  defp extract_mul(row) do
    Regex.scan(@regex, row)
    |> Enum.map(fn [_match, x, y] -> String.to_integer(x) * String.to_integer(y) end)
    |> Enum.sum()
  end
end
