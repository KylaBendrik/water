defmodule PuzzleTest do
  use ExUnit.Case
  doctest Water.Puzzle
  
  test "find_drops(0, 4) returns []" do
    assert Water.Puzzle.find_drops(0, 4) == []
  end
  
  test "find_drops(1, 4) returns 'AAAA'" do
    assert Water.Puzzle.find_drops(1, 4) == 'AAAA'
  end
  
  test "transfer drop from first vial and drop into last (empty) vial" do
    puzzle = %Water.Puzzle{vials: ['BBAA', 'AABB', [], []], vial_size: 4}
    new_puzzle =  Water.transfer(puzzle, 0, 3)
    assert new_puzzle.vials == ['BB', 'AABB', [], 'AA']
  end
end
