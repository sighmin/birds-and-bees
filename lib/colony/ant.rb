class Ants::Colony::Ant

  attr_accessor :x, :y, :item

  def initialize(config, position = {x: 0, y: 0}, grid = nil)
    @@config   = config
    @@grid     = grid
    @x         = position[:x]
    @y         = position[:y]
    @item      = nil
  end

  def perceive_and_act
    if unladen? and @@grid.item_at?(position)
      item = @@grid.get(position)
      pickup_probability = item.pickup_probability(item, @@grid.neighbors(item.position), @@config[:patchsize])
      # if U(0,1) < Pp(Ya) then pickup(item) end
      if Ants::Utils.random() < pickup_probability
        pickup_item
      end
    elsif laden? and @@grid.empty_at?(position)
      drop_probability = @item.drop_probability(@item, @@grid.neighbors(@item.position), @@config[:patchsize])
      if Ants::Utils.random() < drop_probability
        drop_item
      end
    else
      # unable to act:
      # 1. Laden & can't pile item on another item
      # 2. Unladen & no item to pickup
    end
  end

  def move
    neighbor_site = @@grid.adjacent_sites(position).sample
    walk_towards(neighbor_site)
  end

  def position
    {x: @x, y: @y}
  end

  def position=(position)
    @x = position[:x]
    @y = position[:y]
  end

  def print
    "x"
  end

protected

  def pickup_item
    @item = @@grid.get(position)
    @@grid.set(position, self)
  end

  def drop_item
    @@grid.set(position, @item)
    @item = nil
  end

  def walk_towards(site)
    current_position = {x: @x, y: @y}
    @x = site[:x]
    @y = site[:y]
    @@grid.move(current_position, site)
  end

  def unladen?
    @item.nil?
  end

  def laden?
    not unladen?
  end

end
