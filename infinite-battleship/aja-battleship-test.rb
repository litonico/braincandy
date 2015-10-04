require 'minitest/autorun'
require './aja-battleship'

class TestBattleship < Minitest::Test
  def setup
    @game = Battleship.new
  end

  def test_fire_can_hit
    @game.grid[:patrol] = [[5,5], [5,4]]
    assert_equal [:hit, :patrol], @game.fire([5,5])
  end

  def test_fire_can_sink
    @game.grid[:patrol] = [[5,5], [5,4]]
    assert_equal [:hit, :patrol], @game.fire([5,5])
    assert_equal [:sunk, :patrol], @game.fire([5,4])
  end

  def test_fire_can_miss
    assert_equal :splash, @game.fire([2,2])
  end

  def test_can_place_a_boat
    @game.place(:carrier, :north, [0,0])
    assert_equal [0, 0], @game.grid[:carrier][0]
    assert_equal [0,-1], @game.grid[:carrier][1]
    assert_equal [0,-2], @game.grid[:carrier][2]
    assert_equal [0,-3], @game.grid[:carrier][3]
    assert_equal [0,-4], @game.grid[:carrier][4]
    assert_equal nil,    @game.grid[:carrier][5]
  end
end
