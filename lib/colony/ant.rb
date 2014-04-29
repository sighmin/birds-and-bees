class Ants::Colony::Ant < Ants::Colony::Entity

  attr_accessor :item

  STRICTNESS_COEFF = 2.0

  def initialize grid, x = nil, y = nil
    super grid, x, y
    @type = 'A'
    @item = nil
  end

  def move
    new_x, new_y = valid_move
    #puts "moving #{x},#{y} -> #{new_x},#{new_y}"
    current_cell = grid[x,y]

    # Update old cell
    if current_cell.on_item?
      # @todo replace this with the item held by the ant
      @grid[x,y] = Ants::Colony::UserItem.new(grid, x, y)
    else
      @grid[x,y] = Ants::Colony::Entity.new(x, y, grid)
    end

    # Update new cell
    @x, @y = new_x, new_y
    new_cell = grid[x,y]
    if new_cell.type == 'I'
      @type = 'B' # there was an item there
      @grid[x,y] = self
    else
      @type = 'A' # there was no item there
      @grid[x,y] = self
    end
  end

  def act
    # Perform pick up / drop
    if unladen? && on_item?
      # @todo implement heterogeneous probabilities
      pickup_p = pickup_probability
      if Ants::Utils.random < pickup_p
        @type = 'A'
        @item = 'yes'
        @grid[x,y] = self
      end
    elsif laden? && !on_item?
      # @todo implement heterogeneous probabilities
      drop_p = drop_probability
      if Ants::Utils.random < drop_p
        @type = 'B'
        @item = nil
        @grid[x,y] = self
      end
    else
      # Unable to act:
      # 1. laden & can't pile items on another
      # 2. unladen and no item to pickup
    end
  end

  def on_item?
    type == 'B'
  end

private

  def unladen?
    item.nil?
  end

  def laden?
    !item.nil?
  end

  def is_valid? new_x, new_y
    return false if (new_x == new_y && new_x == 0)
    new_x %= grid.size
    new_y %= grid.size
    !grid.collision?(new_x, new_y)
  end

  def valid_move
    valid = false
    new_x, new_y = 0, 0
    while (!valid)
      new_x = x + Ants::Utils.random(-1..1)
      new_y = y + Ants::Utils.random(-1..1)
      valid = is_valid? new_x, new_y
    end
    return new_x %= grid.size, new_y %= grid.size
  end

  def pickup_probability
    lamda = density
    (1.0 / (1.0 + lamda)) ** STRICTNESS_COEFF
  end

  def drop_probability
    lamda = density
    (lamda / (1.0 + lamda)) ** STRICTNESS_COEFF
  end

  def density
    items = 0
    positions = [[-1,-1],[1,1]] \
              + [[0,1],[1,0]]   \
              + [[0,-1],[-1,0]] \
              + [[1,-1],[-1,1]]
    positions.each do |position|
      items += 1 if grid.item?(x + position[0], y + position[1])
    end
    items
  end
end

