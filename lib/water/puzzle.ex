defmodule Water.Puzzle do
  defstruct vials: [], vial_size: 4
  @moduledoc """
  Water is a simple stacking puzzle. 
  You have a number of vials (nV). You have a number of colors (nV - 2)
  Each vial can hold four "drops" of water. Each color needs to be in one vial. 
  It starts all mixed up, and you have to sort them out.
  
  ABCD BBCC AADD DCBA ____ ____ -> AAAA BBBB CCCC DDDD ____ ____
  """
  def new(num_colors, vial_size) do
    %Water.Puzzle{
      vials: Water.Puzzle.build_puzzle(num_colors, vial_size, []),
      vial_size: vial_size}
  end
  def transfer(puzzle, from_i, to_i) do
    vials = puzzle.vials
    from = Enum.at(vials, from_i)
    to = Enum.at(vials, to_i)
    
    {grabbed, new_from} = Water.Vial.grab(from)
    
    result = grabbed
      |> Water.Vial.fill(to, puzzle.vial_size)
      
    case result do
      {:ok, filled} ->
        changed_vials = vials
          |> List.replace_at(from_i, new_from)
          |> List.replace_at(to_i, filled)
        %Water.Puzzle{vials: changed_vials, vial_size: puzzle.vial_size}
      _ ->
        IO.puts("result is")
        IO.inspect(result)
          puzzle
    end
    
    # returns a new puzzle with the updated vials
  end
  
  
  def build_puzzle(num_colors, vial_size, vials) do
    build_puzzle(Water.Puzzle.find_drops(num_colors, vial_size), num_colors, vial_size, vials)
  end
  
  def build_puzzle(_drops, 0, _vial_size, vials) do
    vials ++ [[], []]
  end
  
  def build_puzzle(drops, num_colors, vial_size, vials) do
    #['AABB', 'BBAA', [], []]
    new_vial = Water.Vial.new(drops, vial_size)
    build_puzzle(drops -- new_vial, num_colors - 1, vial_size, [new_vial | vials])
  end
  
  def check_for_win(puzzle) do
    {false, puzzle}
  end
  
  
  
  def find_drops(num_colors, vial_size) do
    num_colors
      |> do_find_drops([])
      |> populate_drops(vial_size, [])
  end
  
  defp populate_drops(_drops, 0, all_drops) do
    all_drops
  end
  
  defp populate_drops(drops, vial_size, all_drops) do
    populate_drops(drops, vial_size - 1, drops ++ all_drops)
  end
  
  defp do_find_drops(0, drops) do
    drops
  end
  
  defp do_find_drops(num_colors, drops) do
    do_find_drops(num_colors - 1, [64 + num_colors | drops])
  end
  
 
end

defimpl String.Chars, for: Water.Puzzle do
  def to_string(puzzle) do
    IO.inspect(puzzle)
  end
end
