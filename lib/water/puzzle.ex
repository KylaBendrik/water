defmodule Water.Puzzle do
  @moduledoc """
  Water is a simple stacking puzzle. 
  You have a number of vials (nV). You have a number of colors (nV - 2)
  Each vial can hold four "drops" of water. Each color needs to be in one vial. 
  It starts all mixed up, and you have to sort them out.
  
  ABCD BBCC AADD DCBA ____ ____ -> AAAA BBBB CCCC DDDD ____ ____
  """
  
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
