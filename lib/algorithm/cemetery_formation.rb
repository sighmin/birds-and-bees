class Ants::Algorithm::CemeteryFormation

  attr_accessor :config

  def initialize(file = 'config/application.yml', config = {})
    @config = Ants::parse_yml(file)
    @config.merge!(config)
  end

  def run
    "running cemetery formation algorithm"
  end
end
