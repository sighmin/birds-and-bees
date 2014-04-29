class Ants::Colony::Item < Ants::Colony::Entity

  attr_accessor :status
  # status = 0 for unvisited
  #          1 for visited
  #          2 for noise

  def initialize grid, x = nil, y = nil
    super grid, x, y
    @type = 'I'
    @status = 0
  end
end
