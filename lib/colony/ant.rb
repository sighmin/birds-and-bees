class Ants::Colony::Ant

  attr_accessor :x, :y

  def initialize(config, grid = nil)
    @@config = config
    @@grid   = grid
  end

  def self.move
    "ant moving"
  end

  def self.act
    "ant picking/dropping"
  end

  def position
    {x: @x, y: @y}
  end
end
