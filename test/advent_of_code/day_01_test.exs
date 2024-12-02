defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Day01

  test "part1" do
    input = "3   4\n4   3\n2   5\n1   3\n\n3   9\n3   3"
    result = part1(input)

    assert result == 11
  end

  test "part2" do
    input = "3   4\n4   3\n2   5\n1   3\n\n3   9\n3   3"

    result = part2(input)

    assert result == 31
  end
end
