class Ants::Algorithm::CemeteryFormation

  attr_accessor :config, :ants, :items, :grid

  def initialize(file = 'config/application.yml', config = {})
    @config = Ants::parse_yml(file)
    @config.merge!(config)

    init_ants
    init_items
    init_grid
  end

  def init_ants
    @ants = []
    @config[:colonysize].times { @ants << Ants::Colony::Ant.new(@config) }
  end

  def init_items
    @items = []
  end

  def init_grid
    @grid = Matrix.build(@config[:gridsize], @config[:gridsize]) {|x,y| nil}
  end

  def run
    "running cemetery formation algorithm"
  end
end
