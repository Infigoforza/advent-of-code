defmodule AdventOfCode.Day06 do
  def part1(input) do
    grid = parse_map(input)
    start_position = Enum.find_value(grid, &(&1.c === "^" && &1))

    moves(start_position, :up, grid)
    |> Enum.uniq()
    |> length()
  end

  def part2(input) do
    grid = parse_map(input)
    start_position = Enum.find_value(grid, &(&1.c === "^" && &1))
  end

  defp moves(position, direction, grid, paths \\ []) do
    {x, y} = new_cor(direction, position.x, position.y)
    next_position = grid |> Enum.find_value(&(&1.x === x && &1.y === y and &1))

    case next_position do
      %{c: "#"} ->
        new_direction = new_direction(direction)
        moves(position, new_direction, grid, paths)

      nil ->
        [position | paths]

      p ->
        moves(p, direction, grid, [position | paths])
    end
  end

  defp new_direction(:up), do: :right
  defp new_direction(:right), do: :bottom
  defp new_direction(:bottom), do: :left
  defp new_direction(:left), do: :up

  defp new_cor(:up, x, y), do: {x, y - 1}
  defp new_cor(:right, x, y), do: {x + 1, y}
  defp new_cor(:bottom, x, y), do: {x, y + 1}
  defp new_cor(:left, x, y), do: {x - 1, y}

  defp parse_map(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index(fn path, y ->
      path
      |> String.split("", trim: true)
      |> Enum.with_index(&%{x: &2, y: y, c: &1})
    end)
    |> List.flatten()
  end
end
