require 'minitest/autorun'
require './pascal'

class TestPascal < Minitest::Test
  def test_pascal_base_case
    assert_equal [[1]], pascal(0)
  end

  def test_pascal_growing
    assert_equal [[1,1],[1]], pascal(1)
  end

  def test_pascal_growing_more
    assert_equal [[1,3,3,1],[1,2,1],[1,1],[1]], pascal(3)
  end

  def test_pascal_growing_most
    assert_equal [[1,4,6,4,1], [1,3,3,1],[1,2,1],[1,1],[1]], pascal(4)
  end
end

class TestBinomialCoefficient < Minitest::Test
  def test_binomial_coefficient
    assert_equal 1, nCr(1, 1)
    assert_equal 2, nCr(2, 1)
    assert_equal 10, nCr(5, 3)
  end
end
