require 'minitest/autorun'
require './makepi'

class TestPiEstimate < Minitest::Test
  attr_reader :estimator
  def setup
    @estimator = PiEstimator.new
  end

  def test_checking_inside_circle
    assert_equal false, estimator.is_inside?([0.9, 0.9])
    assert_equal true, estimator.is_inside?([0.1, 0.1])
    assert_equal true, estimator.is_inside?([0.7, 0.7])
    assert_equal false, estimator.is_inside?([0.8, 0.8])
  end

  def test_shooting
    x, y = estimator.shoot
    assert_operator 1, :>, x
    assert_operator 1, :>, y
  end

  def test_estimation
    estimator.inside = 22
    estimator.outside = 7
    assert_in_epsilon 3.142857142857, estimator.estimate
  end

  def test_refining_estimate
    srand 42
    estimator.refine_estimate
    assert_equal 0, estimator.estimate
    estimator.refine_estimate
    assert_equal 1, estimator.estimate
    estimator.refine_estimate
    1000.times do
      estimator.refine_estimate
    end
    assert_operator 3, :<, estimator.estimate
    assert_operator 4, :>, estimator.estimate
  end
end
