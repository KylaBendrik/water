defmodule Water.Vial do
  def new(drops, vial_size \\ 4) do
    Enum.take_random(drops, vial_size)
  end
  
  def fill(grabbed_drops, vial, vial_size) do
    check_color = check_colors(grabbed_drops, vial)
    
    if check_color == {:ok, grabbed_drops, vial} do
      filled = vial ++ grabbed_drops
      cond do 
        length(filled) <= vial_size ->
          {:ok, vial ++ grabbed_drops}
        length(filled) > vial_size ->
          [filled_vial, extra] = Enum.chunk_every(filled, vial_size)
          {:not_enough_space, filled_vial, put_back: extra}
      end
    else
      check_color
    end  
  end
  
  defp check_colors(grabbed_drops, vial) do 
    cond do
      List.last(grabbed_drops) == List.last(vial) ->
        {:ok, grabbed_drops, vial}
      vial == []  ->
        {:ok, grabbed_drops, vial}
      true ->
        {:wrong_color, vial, put_back: grabbed_drops}
    end
  end
  
  def check_complete([], _), do: true
  
  def check_complete(vial, vial_size) do
    [head | _rest] = vial
    
    Enum.all?(vial, fn color -> color == head end) && length(vial) == vial_size
  end
  
  def grab(vial) do
    # returns all the drops from the top that match
    {last, rest} = List.pop_at(vial, length(vial) - 1)
    grab_last_if_matching(rest, last, last)
  end
  
  defp grab_last_if_matching(vial, color, result) do
    {next_drop, new_vial} = List.pop_at(vial, length(vial) - 1)
    
    cond do
      next_drop == color ->
        grab_last_if_matching(new_vial, color, List.wrap(result) ++ List.wrap(next_drop))
      true -> 
        {List.wrap(result), List.wrap(vial)}
    end
  end
  

end
