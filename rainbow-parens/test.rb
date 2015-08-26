require 'minitest/autorun'
require './rainbow-parens'

class RainbowsTest < Minitest::Test
  def test_hue
    assert_equal [5, 0, 0], scale(hue(0))     # Red
    assert_equal [5, 2, 0], scale(hue(31))    # Orange
    assert_equal [5, 5, 0], scale(hue(60))    # Yellow
    assert_equal [0, 5, 0], scale(hue(120))   # Green
    assert_equal [0, 5, 5], scale(hue(180))   # Cyan
    assert_equal [0, 0, 5], scale(hue(240))   # Blue
    assert_equal [5, 0, 5], scale(hue(300))   # Magenta
    assert_equal [5, 0, 0], scale(hue(360))   # Red
  end
end
