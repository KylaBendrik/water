defmodule WaterTest do
  use ExUnit.Case
  doctest Water

  # test "new/0 creates a new, 4 vial puzzle" do
  #   puzzle = Water.new()
  #   vials = puzzle.vials
  #   [a, b, c, d] = vials
  #   assert length(vials) == 4
  #   assert length(a) && length(b) == 4
  #   assert length(c) && length(d) == 0
  # end

  test "is a legal transfer recognized as legal moves?" do
    puzzle = %Water.Puzzle{vials: ['AABB', 'ABBA', [], []], vial_size: 4, moves: 0}
    assert Water.check_legal_transfer(puzzle, 0, 2) == {:ok}
  end

  test "is a legal transfer recognized as legal moves even if both vials are full?" do
    puzzle = %Water.Puzzle{vials: ['AABB', 'ABBA', [], []], vial_size: 4, moves: 0}
    assert Water.check_legal_transfer(puzzle, 0, 1) == {:ok}
  end

  test "is an illegal move noticed and stopped?" do
    puzzle = %Water.Puzzle{vials: ['AABB', 'ABBA', [], []], vial_size: 4, moves: 0}
    assert Water.check_legal_transfer(puzzle, 8, 1) == {:error, "'from' is too high"}
    assert Water.check_legal_transfer(puzzle, -8, 1) == {:error, "'from' is too low"}
    assert Water.check_legal_transfer(puzzle, 0, 8) == {:error, "'to' is too high"}
    assert Water.check_legal_transfer(puzzle, 2, -1) == {:error, "'to' is too low"}

    assert Water.check_legal_transfer(puzzle, 2, 2) ==
             {:error, "'from' and 'to' must be different"}
  end
end
