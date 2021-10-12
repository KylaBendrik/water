defmodule PuzzleTest do
  use ExUnit.Case
  doctest Water.Puzzle
  
  test "find_drops(0, 4) returns []" do
    assert Water.Puzzle.find_drops(0, 4) == []
  end
  
  test "find_drops(1, 4) returns 'AAAA'" do
    assert Water.Puzzle.find_drops(1, 4) == 'AAAA'
  end
end
