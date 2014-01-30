class Ants::Sims::Simulation

  attr_accessor :algorithm

  def initialize(algorithm = Ants::Algorithm::CemeteryFormation.new)
    @algorithm = algorithm
  end

  def start
    begin
      @algorithm.run
      true
    rescue StandardError => e
      puts e
      false
    end
  end

end
