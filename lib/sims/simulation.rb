class Ants::Sims::Simulation

  attr_accessor :algorithm, :analyzer

  def initialize algorithm = Algorithm::CemeteryFormation.new, \
                 analyzer  = Sims::Analyzer.new
    @algorithm = algorithm
    @analyzer  = analyzer
    @analyzer.algorithm = @algorithm
  end

  def start
    gracefully do
      algorithm.run
    end
  end

  def analyze
    gracefully do
      analyzer.run
      puts analyzer.report
    end
  end

private

  def gracefully
    yield
  rescue StandardError => e
    puts "Failed gracefully"
    puts e.message
    puts e.backtrace.join("\n")
    # Fail hard on anything else
  end
end
