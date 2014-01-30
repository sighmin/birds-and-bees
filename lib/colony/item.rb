class Ants::Colony::Item

  attr_accessor :x, :y, :data

  def initialize(position = {x: 0, y: 0}, data = {})
    @x    = position[:x]
    @y    = position[:y]
    @data = data
  end

  def position
    {x: @x, y: @y}
  end
end
