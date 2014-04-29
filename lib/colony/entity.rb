class Ants::Colony::Entity

  attr_accessor :x, :y, :grid, :type
  # type = E for empty
  #        A for ant
  #        I for item
  #        B for both (ant carrying an item)

  def initialize grid, x = nil, y = nil
    @grid, @x, @y = grid, x, y
    @type = 'E'
  end

  def to_s
    "#{x},#{y} | #{type}"
  end
end
