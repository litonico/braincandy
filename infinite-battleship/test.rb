require 'minitest/autorun'
require './battleship'

class TestBattleship < Minitest::Test
  def setup
    @game = Battleship.new
    @p1 = @game.player1
    @p2 = @game.player1
  end

  def test_can_place_a_ship_vertically
    @p1.place(:submarine, :north, [2,2])
    assert_equal [[2,2], [2,1], [2,0]], @p1.ships[:submarine]
  end

  def test_can_place_a_ship_horizontally
    @p1.place(:submarine, :west, [2,2])
    assert_equal [[2,2], [1,2], [0,2]], @p1.ships[:submarine]
  end

  def test_can_hit_a_ship
    @p1.place(:submarine, :north, [2,2])
    assert_equal Shot.new(:hit, :submarine), @p1.fire(@p2, [2,2])
  end

  def test_can_sink_a_ship
    skip
    @p1.place(:submarine, :north, [2,2])
    assert_equal [:hit, :submarine], @p1.fire([2,2])
    assert_equal [:hit, :submarine], @p1.fire([2,1])
    assert_equal [:sunk, :submarine], @p1.fire([2,0])
  end

  def test_cannot_place_two_boats_in_the_same_place
    skip
    @p1.place(:submarine, :north, [2,2])
    assert_raises @p1.place(:carrier, :north, [2,2]), StandardError
  end

  def test_can_place_and_check_boats_far_away
    skip
    @p2.place(:destroyer, :west, [7888888889153,100000000000000016])
    assert_equal true, @p1.fire([7888888889153,100000000000000016])
  end
end
