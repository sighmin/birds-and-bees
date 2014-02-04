class Ants::Colony::Ant

  attr_accessor :x, :y, :item
  @@lambda        = 1.0
  @@lambda_pickup = 1.0
  @@lambda_drop   = 1.0

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
      neighbors = @@grid.neighbor_items(item.position, @@config[:patchsize])
      pickup_probability = pickup_probability(item, neighbors)
      # if U(0,1) < Pp(Ya) then pickup(item) end
      if Ants::Utils.random() < pickup_probability
        pickup_item
      end
    elsif laden? and @@grid.empty_at?(position)
      neighbors = @@grid.neighbor_items(@item.position, @@config[:patchsize])
      drop_probability = drop_probability(@item, neighbors)
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
    @@grid.move(self, site)
  end

  def unladen?
    @item.nil?
  end

  def laden?
    not unladen?
  end

  def pickup_probability(item, neighbors)
    ( @@lambda_pickup/(@@lambda_pickup + local_density(item, neighbors)) ) ** 2
  end

  def drop_probability(item, neighbors)
    density = local_density(item, neighbors)
    if density < @@lambda_drop
      2 * density
    else # >= @@lambda2
      1
    end
  end

  def local_density(item, neighbors)
    inverse_patch_squared = 1.0 / (@@config[:patchsize] ** 2)
    sum_similarity = 0.0
    neighbors.each do |foreign|
      neighbor = @@grid.get(foreign)
      unless neighbor.nil?
        sum_similarity += (1.0 - (item.dissimilarity(neighbor)/@@lambda))
      end
    end
    average_similarity = inverse_patch_squared * sum_similarity
    [0.0, average_similarity].max
  end

end
