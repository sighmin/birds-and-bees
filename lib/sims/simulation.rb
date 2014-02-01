class Ants::Sims::Simulation

  attr_accessor :algorithm

  def initialize(algorithm = Ants::Algorithm::CemeteryFormation.new)
    @algorithm = algorithm
  end

  def start
    begin
      @algorithm.run
    rescue StandardError => e
      puts e
    rescue
      # fail silently
    end
  end

end
