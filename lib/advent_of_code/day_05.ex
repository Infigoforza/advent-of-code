defmodule AdventOfCode.Day05 do
  def part1(input) do
    [instructions, pages] = parse_input(input)

    Enum.map(pages, fn page ->
      is_valid? =
        instructions
        |> Enum.map(&check_instructions(&1, page))
        |> Enum.all?()

      if is_valid? do
        index = ((length(page) - 1) / 2) |> round()
        page |> Enum.at(index) |> String.to_integer()
      else
        0
      end
    end)
    |> Enum.sum()
  end

  def part2(input) do
    [instructions, pages] = parse_input(input)

    Enum.map(pages, fn page ->
      is_valid? =
        instructions
        |> Enum.map(&check_instructions(&1, page))
        |> Enum.all?()

      unless is_valid? do
        index = ((length(page) - 1) / 2) |> round()

        page
        |> Enum.sort(fn x, y -> Enum.any?(instructions, &([x, y] == &1)) end)
        |> Enum.at(index)
        |> String.to_integer()
      else
        0
      end
    end)
    |> Enum.sum()
  end

  defp check_instructions(_, _page, keep_checking \\ true)
  defp check_instructions(_, _page, false), do: false
  defp check_instructions([], _page, is_valid), do: is_valid

  defp check_instructions([left, right | instructions], page, is_valid) do
    if left in page and right in page do
      li = Enum.find_index(page, &(&1 == left))
      ri = Enum.find_index(page, &(&1 == right))

      check_instructions(instructions, page, li < ri)
    else
      check_instructions(instructions, page, is_valid)
    end
  end

  defp parse_input(input) do
    [instructions, rows] =
      input
      |> String.split(~r/^\n/m, trim: true)

    rules =
      instructions |> String.split("\n", trim: true) |> Enum.map(&String.split(&1, "|"))

    pages = rows |> String.split("\n", trim: true) |> Enum.map(&String.split(&1, ","))

    [rules, pages]
  end
end
