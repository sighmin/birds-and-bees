class Ants::Colony::Ant < Colony::Entity

  attr_accessor :item

  PICKUP_STRICTNESS_COEFF = 1.5
  DROP_STRICTNESS_COEFF   = 1.5

  def initialize grid, x = nil, y = nil
    super grid, x, y
    @type = 'A'
    @item = nil
  end

  def move
    new_x, new_y = valid_move
    #puts "moving #{x},#{y} -> #{new_x},#{new_y}"
    current_position = grid[x,y]

    # Update old cell
    if current_position.on_item?
      # @todo replace this with the item held by the ant
      self.grid.set_item x, y
    else
      self.grid.set_entity x, y
    end

    # Update ant internal state
    self.x, self.y = new_x, new_y
    if laden?
      self.item.x, self.item.y = new_x, new_y
    end

    # Update new cell
    new_cell = grid[x,y]
    if new_cell.type == 'I'
      self.type = 'B' # there was an item there
      self.grid[x,y] = self
    else
      self.type = 'A' # there was no item there
      self.grid[x,y] = self
    end
  end

  def act
    # Perform pick up / drop
    if unladen? && on_item?
      pickup_p = pickup_probability
      if Ants::Utils.random < pickup_p
        self.type = 'A'
        self.item = self.grid.get_item x, y
        self.grid.update_item self.item, x, y
        self.grid[x,y] = self
      end
    elsif laden? && !on_item?
      drop_p = drop_probability
      if Ants::Utils.random < drop_p
        self.type = 'B'
        self.grid.update_item self.item, x, y
        self.item = nil
        self.grid[x,y] = self
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

  def unladen?
    item.nil?
  end

  def laden?
    !item.nil?
  end

private

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
    probability = (1.0 / (1.0 + lamda)) ** PICKUP_STRICTNESS_COEFF
    #puts "pickup: #{probability}"
    probability
  end

  def drop_probability
    lamda = density
    probability = (lamda / (1.0 + lamda)) ** DROP_STRICTNESS_COEFF
    #puts "drop: #{probability}"
    probability
  end

  def density
    similarity_total = 0.0
    positions = [[-1,-1],[1,1]] \
              + [[0,1],[1,0]]   \
              + [[0,-1],[-1,0]] \
              + [[1,-1],[-1,1]]
    positions.each do |position|
      mod_x = (x + position[0]) % grid.size
      mod_y = (y + position[1]) % grid.size
      if grid.item?(mod_x, mod_y)
        similarity_total += similarity(grid.get_item(x,y), grid.get_item(mod_x, mod_y))
      end
    end
    similarity_total
  end

  def similarity item_a, item_b
    item_a.similarity_index item_b
  end
end

