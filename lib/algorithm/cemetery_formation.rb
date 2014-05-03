class Ants::Algorithm::CemeteryFormation

  attr_accessor :config, :ants, :items, :grid, :dataset

  def initialize config = {}
    @config = Ants::parse_yml 'config/parameters.yml'
    @config.merge! config
    @dataset = Ants::generate_data @config
    @ants, @items = [], []
    @grid = Ants::Grid.new(@config[:gridsize], @ants, @items)

    init_entities
    place_entities
  end

  def run
    puts "===> Algorithm starting!"
    initial_grid = grid.to_s

    config[:iterations].times do |i|
      print_grid i
      ants.each do |ant|
        ant.move
        ant.act
      end
    end

    puts "\n===> Algorithm complete!"
    puts "===> Initial clustering:"
    puts initial_grid
    puts "===> Final clustering:"
    puts grid.to_s
  end

  def print_grid i
    return unless (i % config[:print_resolution] == 0)
    puts "Iteration # #{i}"
    puts grid.to_s
  end

private

  def init_entities
    # init ants
    config[:colonysize].times do
      self.ants << Ants::Colony::Ant.new(self.grid)
    end

    # init items
    self.dataset.each do |data|
      self.items << Ants::Colony::UserItem.new(self.grid, data)
    end
  end

  def place_entities
    # place ants
    i = 0
    while (i < ants.count) do
      x, y = Ants::Utils.random(grid.size), Ants::Utils.random(grid.size)
      if (self.grid[x,y].type == 'E')
        self.grid[x,y] = self.ants[i]
        self.ants[i].x = x
        self.ants[i].y = y
      else
        i -= 1
      end
      i += 1
    end

    # place items
    i = 0
    while (i < items.count) do
      x, y = Ants::Utils.random(grid.size), Ants::Utils.random(grid.size)
      if (self.grid[x,y].type == 'E')
        self.grid[x,y] = self.items[i]
        self.items[i].x = x
        self.items[i].y = y
      else
        i -= 1
      end
      i += 1
    end
  end

end
