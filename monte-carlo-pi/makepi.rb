class PiEstimator
  attr_accessor :inside, :outside
  def initialize
    self.inside = 0
    self.outside = 0
  end

  def shoot
    [rand, rand]
  end

  def is_inside? point
    x, y = point
    x**2 + y**2 < 1
  end

  def estimate
    unless outside == 0
      inside.to_f/outside
    else
      0
    end
  end

  def refine_estimate
    if is_inside? shoot
      self.inside += 1
    else
      self.outside += 1
    end
  end
end
