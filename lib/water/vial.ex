defmodule Water.Vial do
  def new(drops, vial_size \\ 4) do
    Enum.take_random(drops, vial_size)
  end
end
