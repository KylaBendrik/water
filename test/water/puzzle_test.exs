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
  
  test "transfer fails if from vial doesn't match to" do
    puzzle = %Water.Puzzle{vials: ['ABBA', 'AA', 'BB', []], vial_size: 4}
    new_puzzle =  Water.transfer(puzzle, 0, 2)
    assert new_puzzle.vials == ['ABBA', 'AA', 'BB', []]
  end
  
  test "check for win conditions" do
    winning_puzzle1 = %Water.Puzzle{vials: ['AAAA', [], []], vial_size: 4}
    #not_winning_puzzle1 = %Water.Puzzle{vials: ['AA', 'AA', []], vial_size: 4}
    assert Water.Puzzle.check_for_win(winning_puzzle1) == {true, winning_puzzle1}
    #assert Water.Puzzle.check_for_win(not_winning_puzzle1)  == {false, not_winning_puzzle1}
  end
  
  test "find current moves made" do
    puzzle = %Water.Puzzle{vials: ['AAAA', [], []], vial_size: 4, moves: 2}
    
    assert Water.Puzzle.moves(puzzle) == 2
  end
  
  test "moves increment after transfer" do
    puzzle = %Water.Puzzle{vials: ['BBAA', 'AABB', [], []], vial_size: 4, moves: 0}
    assert Water.Puzzle.moves(puzzle) == 0
    
    puzzle = Water.transfer(puzzle, 0, 3)
    assert Water.Puzzle.moves(puzzle) == 1
  end
end
