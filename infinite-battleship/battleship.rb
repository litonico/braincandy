class Shot
  attr_reader :value, :ship
  def initialize value, ship
    @value = value
    @ship = ship
  end

  def == other
    value == other.value && ship == other.ship
  end

  def hash
    [value, ship].hash
  end
end

SHIPS = {
    carrier: 5,
    battleship: 4,
    destroyer: 3,
    submarine: 3,
    patrol: 3
}

class Player
  attr_reader :ships
  def initialize
    @ships = {}
  end

  def place ship, dir, coord
    self.ships[ship] = ship_sections ship, dir, coord
  end

  def ship_sections ship, dir, coord
    if dir == :north
      (0...SHIPS[ship]).map do |c|
        [coord[0], coord[1]-c]
      end
    elsif dir == :west
      (0...SHIPS[ship]).map do |c|
        [coord[0]-c, coord[1]]
      end
    end
  end

  def hit? coord
    ships.each do |name, ship|
      ship.hit? coord
    end
  end

  def fire enemy, coord
    enemy.hit? coord
  end
end

class Battleship
  attr_reader :player1, :player2
  def initialize
    @player1 = Player.new
    @player2 = Player.new
  end
end
