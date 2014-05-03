class Ants::Colony::Item < Colony::Entity

  attr_accessor :status
  STATUSES = [ :unvisited, :visited, :noise ]

  def initialize grid, x = nil, y = nil
    super grid, x, y
    @type = 'I'
    @status = :unvisited
  end

  def visit
    self.status = :visited
  end

  def noise
    self.status = :noise
  end

  def visited?
    !unvisited?
  end

  def unvisited?
    status == :unvisited
  end
end
