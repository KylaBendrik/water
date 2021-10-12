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
  
  def check_complete(vial, vial_size) do
    [head| rest] = vial
    # IO.puts("check vial")
    # IO.inspect(vial)
    cond do
      run_check(head, head, rest) && length(vial) == vial_size ->
        # IO.puts("true, done")
        true
      length(vial) == 0 ->
        # IO.puts("true, empty")
        true
      true ->
        # IO.puts("false")
        false
    end
    
  end
  
  defp run_check(_to_check, _against, []) do
    # IO.puts("done with run_check")
    true
  end
  defp run_check(to_check, against, rest) do
    # IO.puts("check")
    # IO.puts(to_check)
    # IO.puts("against")
    # IO.puts(against)
      if to_check == against do
        [new_check | left] = rest
        run_check(new_check, against, left)
      else
        false
      end

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
        grab_last_if_matching(new_vial, color, listify(result) ++ listify(next_drop))
      true -> 
        {listify(result), listify(vial)}
    end
  end
  
  defp listify(item) do
    if is_list(item) do
      item
    else
      [item]
    end
  end
end
