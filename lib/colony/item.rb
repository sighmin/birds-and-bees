class Ants::Colony::Item

  attr_accessor :x, :y, :data

  def initialize(position = {x: 0, y: 0}, data = nil)
    @x    = position[:x]
    @y    = position[:y]
    @data = data
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

  def self.pickup_probability(item, neighbors)
    raise "NotOverridedInSubclassException"
  end

  def self.drop_probability(item, neighbors)
    raise "NotOverridedInSubclassException"
  end

protected

  def self.dissimilarity(item, neighbors)
    raise "NotOverridedInSubclassException"
  end
end

