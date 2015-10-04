class Array
  def v_add v2
    [self[0]+v2[0], self[1]+v2[1]]
  end

  def s_mul s
    self.map{|n| n*s}
  end
end

class Battleship
  SHIPS = {
    carrier: 5,
    battleship: 4,
    destroyer: 3,
    sub: 3,
    patrol: 2
  }

  attr_accessor :grid
  def initialize
    @grid = {}
  end

  def fire coords
    grid.each do |boat, pos|
      if pos.any? {|c| c == coords}
        pos.delete coords
        if pos.empty?
          return [:sunk, boat]
        else
          return [:hit, boat]
        end
      end
    end
    :splash
  end

  def place boat, dir, nose_coord
    if dir == :north
      offset = [0,-1]
    else
      offset = [-1,0]
    end
    coords = []
    c = nose_coord
    SHIPS[boat].times do |n|
      coords << c
      c = c.v_add(offset)
    end
    grid[boat] = coords
  end
end
