class Ants::Colony::Ant < Ants::Colony::Entity

  def initialize grid, x = nil, y = nil
    super grid, x, y
    @type = 'A'
  end

  def move

  end
end
