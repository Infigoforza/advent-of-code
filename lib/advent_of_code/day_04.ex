defmodule AdventOfCode.Day04 do
  def part1(input) do
    rows = extract_rows(input)

    rows
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, row_index} ->
      Enum.with_index(row)
      |> Enum.map(fn {char, char_index} ->
        if char == "X" do
          check_xmas(rows, char_index, row_index)
        else
          0
        end
      end)
    end)
    |> Enum.sum()
  end

  defp check_xmas(rows, x, y) do
    inc = fn x -> x + 1 end
    dec = fn x -> x - 1 end
    same = fn x -> x end

    words = [
      get_word(rows, x, y, inc, inc, 0),
      get_word(rows, x, y, dec, dec, 0),
      get_word(rows, x, y, inc, dec, 0),
      get_word(rows, x, y, dec, inc, 0),
      get_word(rows, x, y, inc, same, 0),
      get_word(rows, x, y, same, inc, 0),
      get_word(rows, x, y, dec, same, 0),
      get_word(rows, x, y, same, dec, 0)
    ]

    Enum.count(words, &(&1 == "XMAS"))
  end

  def get_word(_, _, _, _, _, 4), do: ""
  def get_word(_, x, y, _, _, _) when x < 0 or y < 0, do: ""

  def get_word([first_row | _] = rows, x, y, _, _, _)
      when y >= length(rows) or x >= length(first_row),
      do: ""

  def get_word(rows, x, y, x_iterator, y_iterator, depth) do
    c = get_char(rows, x, y)

    new_x = x_iterator.(x)
    new_y = y_iterator.(y)
    c <> get_word(rows, new_x, new_y, x_iterator, y_iterator, depth + 1)
  end

  def part2(input) do
    rows = extract_rows(input)

    rows
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, row_index} ->
      Enum.with_index(row)
      |> Enum.map(fn {char, char_index} ->
        if char == "A" and char_index > 0 and row_index > 0 and row_index < length(rows) - 1 and
             char_index < length(row) - 1 do
          check_x_mas(rows, char_index, row_index)
        else
          0
        end
      end)
    end)
    |> Enum.sum()
  end

  defp extract_rows(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "", trim: true))
  end

  defp check_x_mas(rows, x, y) do
    char_a = get_char(rows, x, y)

    [
      [get_char(rows, x - 1, y - 1), char_a, get_char(rows, x + 1, y + 1)] |> Enum.sort(),
      [get_char(rows, x - 1, y + 1), char_a, get_char(rows, x + 1, y - 1)] |> Enum.sort()
    ]
    |> count_x_mas()
  end

  defp count_x_mas([["A", "M", "S"], ["A", "M", "S"]]), do: 1
  defp count_x_mas(_), do: 0

  defp get_char(rows, x, y) do
    rows |> Enum.at(y) |> Enum.at(x)
  end
end
