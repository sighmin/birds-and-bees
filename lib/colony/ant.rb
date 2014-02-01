class Ants::Colony::Ant

  attr_accessor :x, :y

  def initialize(config, position = {x: 0, y: 0}, grid = nil)
    @@config   = config
    @@grid     = grid
    @x         = position[:x]
    @y         = position[:y]
    @item      = nil
  end

  def perceive_and_act
    if unladen? and @grid.item_at?(position)
      # compute lambda(Ya)
      # compute Pp(Ya)
      # if U(0,1) < Pp(Ya) then pickup(item) end
    elsif laden? and @grid.empty_at?(position)
      # compute lambda(Ya)
      # compute Pd(Ya)
    else
      # unable to act
    end
  end

  def move
    neighbor_sites = @grid.adjacent_sites(position)
    neighbor_site  = neighbor_sites.sample
    walk_towards(neighbor_site)
  end

  def walk_towards(site)
    # update position
  end

  def position
    {x: @x, y: @y}
  end

  def print
    "x"
  end

private

  def unladen?
    @item.nil?
  end

  def laden?
    not unladen?
  end

end
