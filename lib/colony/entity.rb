class Ants::Colony::Entity

  attr_accessor :x, :y, :grid, :type, :status
  # type = E for empty
  #        A for ant
  #        I for item
  #        B for both (ant carrying an item)
  # status = 0 for unvisited
  #          1 for visited
  #          2 for noise

  def initialize grid, x = nil, y = nil
    @grid, @x, @y = grid, x, y
    @type = 'E'
    @status = 0
  end

  def to_s
    "#{x},#{y} | #{type}"
  end
end
