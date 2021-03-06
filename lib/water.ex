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
    Water.Puzzle.new(num_colors, vial_size)
    run(Water.Puzzle.new(num_colors, vial_size))
  end

  def transfer(puzzle, from, to) do
    Water.Puzzle.transfer(puzzle, from, to)
  end

  def run(puzzle) do
    IO.inspect(puzzle)
    IO.puts("ready to transfer!")
    from = String.to_integer(String.trim(IO.gets("From: ")))
    to = String.to_integer(String.trim(IO.gets("To: ")))

    case check_legal_transfer(puzzle, from, to) do
      {:error, message} ->
        IO.puts(message)

        puzzle
        |> Water.run()

      {:ok} ->
        puzzle
        |> transfer(from, to)
        |> Water.check_for_win()
        |> Water.run()
    end
  end

  def check_legal_transfer(puzzle, from, to) do
    from_small_enough? = from < length(puzzle.vials)
    to_small_enough? = to < length(puzzle.vials)
    from_big_enough? = from >= 0
    to_big_enough? = to >= 0

    cond do
      !from_small_enough? ->
        {:error, "'from' is too high"}

      !from_big_enough? ->
        {:error, "'from' is too low"}

      !to_small_enough? ->
        {:error, "'to' is too high"}

      !to_big_enough? ->
        {:error, "'to' is too low"}

      from == to ->
        {:error, "'from' and 'to' must be different"}

      true ->
        {:ok}
    end
  end

  def check_for_win(puzzle) do
    case Water.Puzzle.check_for_win(puzzle) do
      {true, puzzle} ->
        IO.puts("You win!")
        IO.inspect(puzzle)
        System.halt(0)

      {false, puzzle} ->
        puzzle
    end
  end
end
