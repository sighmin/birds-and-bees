class Ants::Sims::Simulation

  attr_accessor :algorithm

  def initialize(algorithm = Ants::Algorithm::CemeteryFormation.new)
    gracefully do
      @algorithm = algorithm
    end
  end

  def start
    gracefully do
      @algorithm.run
    end
  end

  # @todo add logging!
  def gracefully(&block)
    begin
      yield
    rescue StandardError => e
      puts e
    rescue
      # fail silently
    end
  end

end
