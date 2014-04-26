class Ants::Colony::Ant < Ants::Colony::Entity

  attr_accessor :item

  def initialize grid, x = nil, y = nil
    super grid, x, y
    @type = 'A'
    @item = nil
  end

  def move
    new_x, new_y = valid_move
    puts "moving #{x},#{y} -> #{new_x},#{new_y}"
    current = grid[x,y]

    # Update old cell
    if current.type == 'B'
      # @todo replace this with the item held by the ant
      @grid[x,y] = Ants::Colony::UserItem.new(grid, x, y)
    else
      @grid[x,y] = Ants::Colony::Entity.new(x, y, grid)
    end

    # Update new cell
    @x, @y = new_x, new_y
    newposition = grid[x,y]
    if newposition.type == 'I'
      @type = 'B' # there was an item there
      @grid[x,y] = self
    else
      @type = 'A' # there was no item there
      @grid[x,y] = self
    end
  end

  def act
    # Perform pick up / drop
    if unladen? && type == 'B'
      # @todo implement heterogeneous probabilities
      pickup_p = 1.0
      if Ants::Utils.random < pickup_p
        @type = 'A'
        @item = 'yes'
        @grid[x,y] = self
      end
    elsif laden? && type == 'A'
      # @todo implement heterogeneous probabilities
      drop_p = 1.0
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
      new_x = @x + Ants::Utils.random(-1..1)
      new_y = @y + Ants::Utils.random(-1..1)
      valid = is_valid? new_x, new_y
    end
    return new_x %= grid.size, new_y %= grid.size
  end
end

