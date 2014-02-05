class Ants::Algorithm::CemeteryFormation

  attr_accessor :config, :ants, :items, :grid, :dataset

  def initialize(config = {}, configfile = 'config/parameters.yml', datafile = 'config/mock_users.yml')
    @config = Ants::parse_yml(configfile)
    @config.merge!(config)
    @dataset = Ants::parse_array_yml(datafile)

    init_grid
    init_items
    init_ants
  end

  def run
    @config[:iterations].times { |i| iteration(i) }
    puts "***> Algorithm complete!"
    puts "***> Final clustering result"
    puts @grid.to_s
  end

  def iteration(i)
    print_grid(i)
    @ants.each do |ant|
      ant.perceive_and_act
      ant.move
    end
    find_hidden_ants
  end

private

  def init_grid
    @grid = Ants::Grid.build(@config[:gridsize], @config[:gridsize]) {|x,y| nil}
  end

  def init_ants
    @ants = []
    @config[:colonysize].times do
      position = @grid.sample_nil_position
      @ants << Ants::Colony::Ant.new(@config, position, grid)
    end
    @grid.place(@ants)
  end

  def init_items
    @items = []
    @dataset.each do |data|
      position = @grid.sample_nil_position
      @items << Ants::Colony::UserItem.new(position, data)
    end
    @grid.place(@items)
  end

  def find_hidden_ants
    @ants.each do |ant|
      if @grid.empty_at?(ant.position)
        @grid.set(ant.position, ant)
      end
    end
  end

  def print_grid(i)
    if i % @config[:print_resolution] == 0
      puts "Iteration # #{i}"
      puts @grid.to_s
    end
  end
end

