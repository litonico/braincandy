require 'minitest/autorun'

def roll
  Array.new(5) { rand(6) + 1 }
end

class Array
  def count_all
    self.reduce(Hash.new(0)) {|counts, elem| counts[elem] += 1; counts}
  end
end

def yahtzee dice
  dice.uniq.length == 1
end

def large_straight dice
  dice.uniq.length == 5
end

def small_straight dice
  dice.uniq.length == 4 &&
  dice.uniq.sort.each_cons(2).all? {|d1, d2| d2 - d1 == 1 }
end

def full_house dice
  dice.count_all.values.sort == [2, 3]
end

def four_of_a_kind dice
  dice.count_all.values.sort == [1, 4]
end

def three_of_a_kind dice
  dice.uniq.length == 3
end

def sixes dice
  dice.count_all[6] == 2
end

def fives dice
  dice.count_all[5] == 2
end

def fours dice
  dice.count_all[4] == 2
end

def threes dice
  dice.count_all[3] == 2
end

def twos dice
  dice.count_all[2] == 2
end

def ones dice
  dice.count_all[1] == 2
end

def score dice
  if yahtzee dice
    50
  elsif large_straight dice
    40
  elsif small_straight dice
    30
  elsif full_house dice
    25
  elsif four_of_a_kind dice
    dice.reduce(:+)
  elsif three_of_a_kind dice
    dice.reduce(:+)
  elsif sixes dice
    6*2
  elsif fives dice
    5*2
  elsif fours dice
    4*2
  elsif threes dice
    3*2
  elsif twos dice
    2*2
  elsif ones dice
    1*2
  else
    0
  end
end

class TestDiceScores < Minitest::Test
  def test_yahtzee
    assert_equal true,  yahtzee([5,5,5,5,5])
    assert_equal false, yahtzee([5,5,5,5,4])
  end

  def test_large_straight
    assert_equal true,  large_straight([1,2,3,4,5])
    assert_equal false, large_straight([1,1,3,4,5])
  end

  def test_small_straight
    assert_equal true,  small_straight([4,2,3,4,5])
    assert_equal true,  small_straight([1,2,3,4,1])
    assert_equal false, small_straight([1,1,3,4,5])
  end

  def test_full_house
    assert_equal true,  full_house([4,4,4,6,6])
    assert_equal false, full_house([4,4,4,4,6])
    assert_equal false, full_house([1,1,3,4,5])
  end

  def test_four_of_a_kind
    assert_equal true,  four_of_a_kind([4,4,4,4,2])
    assert_equal false, four_of_a_kind([4,4,4,6,6])
    assert_equal false, four_of_a_kind([1,1,3,4,5])
  end

  def test_three_of_a_kind
    assert_equal true,  three_of_a_kind([4,4,4,6,2])
    assert_equal false, three_of_a_kind([4,4,4,6,6])
    assert_equal false, three_of_a_kind([1,1,3,4,5])
  end

  def test_doubles
    assert_equal true,  sixes([4,4,4,6,6])
    assert_equal false, sixes([1,1,3,4,5])
    assert_equal true,  fives([4,5,4,5,6])
    assert_equal false, fives([1,1,3,4,5])
    assert_equal true,  fours([4,5,4,5,6])
    assert_equal false, fours([1,1,3,4,5])
    assert_equal true,  threes([3,3,4,5,6])
    assert_equal false, threes([1,1,3,4,5])
    assert_equal true,  twos([2,3,4,2,6])
    assert_equal false, twos([1,1,3,4,5])
    assert_equal true,  ones([1,1,3,4,5])
  end

  def test_scores
    assert_equal 2,  score([1,1,3,4,5])
    assert_equal 40,  score([1,2,3,4,5])
    assert_equal 50,  score([5,5,5,5,5])
  end

end
