defmodule VialTest do
  use ExUnit.Case
  doctest Water.Vial
  
  test "grab the last drop" do
    vial = 'AAAB'
    
    assert Water.Vial.grab(vial) == 'B'
  end

  test "grab all the drops of matching colors" do
    two_drops = 'AABB'
    three_drops = 'ABBB'
    four_drops = 'BBBB'
    complicated_two_drops = 'ABABBAA'
    
    assert Water.Vial.grab(two_drops) == 'BB'
    assert Water.Vial.grab(three_drops) == 'BBB'
    assert Water.Vial.grab(four_drops) == 'BBBB'
    assert Water.Vial.grab(complicated_two_drops) == 'AA'
  end
  
  test "fill grabbed drops into vial (simple)" do
    grabbed= 'AA'
    vial = 'AA'
    
    assert Water.Vial.fill(grabbed, vial, 4) == {:ok, 'AAAA'}
  end
  
  test "fill grabbed drops into vial (not enough space)" do
    grabbed= 'AA'
    vial = 'AAA'
    
    assert Water.Vial.fill(grabbed, vial, 4) == {:not_enough_space, 'AAAA', put_back: 'A'}
  end
  
  test "fill doesn't put the wrong color in the vial" do
    grabbed = 'A'
    vial = 'B'
    
    assert Water.Vial.fill(grabbed, vial, 4) == {:wrong_color, 'B', put_back: 'A'}
  end
end
