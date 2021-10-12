defmodule Water do
  @moduledoc """
  Water is a simple stacking puzzle. 
  You have a number of vials (nV). You have a number of colors (nV - 2)
  Each vial can hold four "drops" of water. Each color needs to be in one vial. 
  It starts all mixed up, and you have to sort them out.
  
  ABCD BBCC AADD DCBA ____ ____ -> AAAA BBBB CCCC DDDD ____ ____
  Vials are listed as bottom to top:
  
  ABCD
    ==
    D
    C
    B
    A
  """

 
  def new(num_colors \\ 2, vial_size \\ 4) do
    Water.Puzzle.build_puzzle(num_colors, vial_size, [])
  end
  
  def transfer(puzzle, from, to) do
    IO.puts(from)
    IO.puts(to)
    ['BB', 'AABB', [], 'AA']
  end
end
