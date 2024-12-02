defmodule AdventOfCode.Day01 do
  def part1(input) do
    {xs, ys} = to_lists(input)

    Enum.sort(xs)
    |> Enum.sort()
    |> Enum.zip(Enum.sort(ys))
    |> Enum.reduce(0, fn {a, b}, acc -> abs(a - b) + acc end)
  end

  def part2(input) do
    {xs, ys} = to_lists(input)

    xs
    |> Enum.reduce(0, fn x, acc ->
      x * Enum.count(ys, fn y -> y == x end) + acc
    end)
  end

  defp to_lists(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.reduce({[], []}, fn line, {acc1, acc2} ->
      [n1, n2] = String.split(line, "   ", trim: true)
      {[String.to_integer(n1) | acc1], [String.to_integer(n2) | acc2]}
    end)
  end
end
