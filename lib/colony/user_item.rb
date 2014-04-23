class Ants::Colony::UserItem < Ants::Colony::Entity

  def initialize grid, x = nil, y = nil
    super grid, x, y
    @type = 'I'
  end
end
