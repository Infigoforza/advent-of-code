defmodule AdventOfCode.Day04 do
  def part1(input) do
    rows =
      input
      |> String.split("\n")
      |> Enum.map(&String.split(&1, "", trim: true))

    rows
    |> Enum.with_index(fn row, row_index ->
      Enum.with_index(row, fn char, char_index ->
        if char == "X" do
          check_xmas(rows, char_index, row_index)
        end
      end)
    end)
  end

  defp check_xmas(rows, x, y) do
    inc = fn x -> x + 1 end
    dec = fn x -> x - 1 end
    same = fn x -> x end

    words = [
      get_word(rows, x, y, inc, inc, 0),
      get_word(rows, x, y, dec, dec, 0),
      get_word(rows, x, y, inc, dec, 0),
      get_word(rows, x, y, dec, dec, 0),
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
      when length(rows) >= y or length(first_row) >= x,
      do: ""

  def get_word(rows, x, y, x_iterator, y_iterator, depth) do
    c = rows |> elem(y) |> elem(x)
    new_x = x_iterator.(x)
    new_y = y_iterator.(y)
    c + get_word(rows, new_x, new_y, x_iterator, y_iterator, depth + 1)
  end

  # defp check_xmas(rows, char_index, row_index) do
  #   current_row = rows[row_index]

  #   Enum.map(1..3, fn offset ->
  #     prev_rows = rows[offset + row_index]
  #   end)

  #   # XMAS
  #   Enum.slice(current_row, char_index..(char_index + 3))
  #   # SAMX
  #   Enum.slice(current_row, char_index..(char_index + 3)//-1)
  # end

  def part2(_args) do
  end
end
