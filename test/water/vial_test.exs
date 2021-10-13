defmodule VialTest do
  use ExUnit.Case
  doctest Water.Vial
  
  test "grab the last drop" do
    vial = 'AAAB'
    
    assert Water.Vial.grab(vial) == {'B', 'AAA'}
  end

  test "grab all the drops of matching colors" do
    two_drops = 'AABB'
    three_drops = 'ABBB'
    four_drops = 'BBBB'
    complicated_two_drops = 'ABABBAA'
    
    assert Water.Vial.grab(two_drops) == {'BB', 'AA'}
    assert Water.Vial.grab(three_drops) == {'BBB', 'A'}
    assert Water.Vial.grab(four_drops) == {'BBBB', ''}
    assert Water.Vial.grab(complicated_two_drops) == {'AA', 'ABABB'}
  end
  
  test "fill grabbed drops into vial (simple)" do
    grabbed= 'AA'
    vial = 'AA'
    
    assert Water.Vial.fill(grabbed, vial, 4) == {:ok, 'AAAA'}
  end
  
  test "fill grabbed drops into vial (not enough space)" do
    grabbed = 'AA'
    to = 'BAA'
    
    assert Water.Vial.fill(grabbed, to, 4) == {:not_enough_space, 'BAAA', put_back: 'A'}
  end
  
  test "fill doesn't put the wrong color in the vial" do
    grabbed = 'A'
    vial = 'B'
    
    assert Water.Vial.fill(grabbed, vial, 4) == {:wrong_color, 'B', put_back: 'A'}
  end
  
  test "check to see if a vial is full and complete" do
    vial_size = 4
    assert Water.Vial.check_complete('AAAA', vial_size)
    assert Water.Vial.check_complete('BBBB', vial_size)
    refute Water.Vial.check_complete('AA', vial_size)
    refute Water.Vial.check_complete('ABBA', vial_size)
  end
end
