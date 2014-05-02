class Ants::Colony::UserItem < Colony::Item

  attr_accessor :data

  def initialize grid, data, x = nil, y = nil
    super grid, x, y
    @data = data
  end
end
