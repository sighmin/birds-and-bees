require "ants/version"

def expand_relative_path(file)
  File.expand_path(File.join('../', file), __FILE__)
end

module Ants
  # Autoload require paths here
  module Sims
    autoload :Simulation,        expand_relative_path('sims/simulation')
  end
  module Algorithm
    autoload :CemeteryFormation, expand_relative_path('algorithm/cemetery_formation')
  end
  module Colony
    autoload :Ant,               expand_relative_path('colony/ant')
    autoload :Item,              expand_relative_path('colony/item')
  end

  # Entry point here
  extend self
  def test
    "Totally awesome test method!"
  end
end
