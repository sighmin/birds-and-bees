class Ants::Algorithm::CemeteryFormation

  attr_accessor :config, :ants, :items, :grid, :dataset

  def initialize config = {}
    @config = Ants::parse_yml 'config/parameters.yml'
    @config.merge! config
    #@dataset = Ants::parse_array_yml @config[:datafile]

    init_grid
    init_ants
    init_items
    place_ants
    place_items
  end

  def run
    puts "===> Algorithm starting!"
    initial_grid = grid.to_s

    @config[:iterations].times do |i|
      print_grid i
      @ants.each do |ant|
        ant.move
        ant.act
      end
    end

    puts "\n===> Algorithm complete!"
    puts "===> Initial clustering:"
    puts initial_grid
    puts "===> Final clustering:"
    puts grid.to_s
    binding.pry
  end

  def print_grid i
    return unless (i % @config[:print_resolution] == 0)
    puts "Iteration # #{i}"
    puts grid.to_s
  end

private

  def init_grid
    @grid = Ants::Grid.new @config[:gridsize]
  end

  def init_ants
    @ants = []
    config[:colonysize].times do
      @ants << Ants::Colony::Ant.new(grid)
    end
  end

  def init_items
    @items = []
    config[:temp_data].times do
      @items << Ants::Colony::UserItem.new(grid)
    end
  end

  def place_ants
    i = 0
    while (i < ants.count) do
      x, y = Ants::Utils.random(grid.size), Ants::Utils.random(grid.size)
      if (@grid[x,y].type == 'E')
        @grid[x,y] = @ants[i]
        @ants[i].x = x
        @ants[i].y = y
      else
        i -= 1
      end
      i += 1
    end
  end

  def place_items
    i = 0
    while (i < items.count) do
      x, y = Ants::Utils.random(grid.size), Ants::Utils.random(grid.size)
      if (@grid[x,y].type == 'E')
        @grid[x,y] = @items[i]
        @items[i].x = x
        @items[i].y = y
      else
        i -= 1
      end
      i += 1
    end
  end
end
