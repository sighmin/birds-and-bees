class Ants::Colony::Ant

  def initialize(config)
    @@config = config
  end

  def self.move
    "ant moving"
  end

  def self.act
    "ant picking/dropping"
  end
end
