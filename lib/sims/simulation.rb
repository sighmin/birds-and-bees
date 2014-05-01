class Ants::Sims::Simulation

  attr_accessor :algorithm

  def initialize algorithm = Ants::Algorithm::CemeteryFormation.new
    @algorithm = algorithm
  end

  def start
    gracefully do
      @algorithm.run
    end
  end

private

  # @todo add logging
  def gracefully
    yield
  rescue StandardError => e
    puts "Failed gracefully"
    puts e.message
    puts e.backtrace.join("\n")
    # Fail on anything else
    binding.pry if e.message == "undefined method `type' for nil:NilClass"
  end
end
