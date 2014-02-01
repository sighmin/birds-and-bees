class Ants::Algorithm::CemeteryFormation

  attr_accessor :config, :ants, :items, :grid, :dataset

  def initialize(config = {}, configfile = 'config/parameters.yml', datafile = 'config/mock_users.yml')
    @config = Ants::parse_yml(configfile)
    @config.merge!(config)
    @dataset = Ants::parse_yml(datafile)

    init_grid
    init_items
    init_ants
  end

  def run
    @config[:iterations].times { iteration() }
  end

  def iteration
    @ants.each do |ant|
      ant.perceive_and_act
      ant.move
    end
  end

private

  def init_grid
    @grid = Ants::Grid.build(@config[:gridsize], @config[:gridsize]) {|x,y| nil}
  end

  def init_items
    @items = []
    @dataset.each do |data|
      position = @grid.sample_nil_position
      @items << Ants::Colony::Item.new(position, data)
    end
    @grid.place(@items)
  end

  def init_ants
    @ants = []
    @config[:colonysize].times do
      position = @grid.sample_nil_position
      @ants << Ants::Colony::Ant.new(@config, position, grid)
    end
    @grid.place(@ants)
  end
end

