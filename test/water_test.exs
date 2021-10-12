defmodule WaterTest do
  use ExUnit.Case
  doctest Water

  test "new/0 creates a new, 4 vial puzzle" do
    puzzle = Water.new()
    IO.puts(puzzle)
    [a, b, c, d] = puzzle
    assert length(puzzle) == 4
    assert length(a) && length(b) == 4
    assert length(c) && length(d) == 0
  end
  
  test "transfer drop from first vial and drop into last (empty) vial" do
    puzzle = ['BBAA', 'AABB', [], []]
             |> Water.transfer(0, 3)
    assert puzzle == ['BB', 'AABB', [], 'AA']
  end
end
