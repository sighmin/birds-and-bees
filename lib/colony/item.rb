class Ants::Colony::Item

  attr_accessor :x, :y, :data

  def initialize(position = {x: 0, y: 0}, data = nil)
    @x    = position[:x]
    @y    = position[:y]
    @data = data

    @@lambda        = 1.0
    @@lambda_pickup = 1.0
    @@lambda_drop   = 1.0
  end

  def position
    {x: @x, y: @y}
  end

  def position=(position)
    @x = position[:x]
    @y = position[:y]
  end

  def print
    "O"
  end

  def dissimilarity(foreign)
    raise "NotOverridedInSubclassException"
  end

end

