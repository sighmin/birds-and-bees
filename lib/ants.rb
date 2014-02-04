require 'ants/version'
require 'yaml'
require 'pry'
require 'matrix'

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
    autoload :UserItem,          expand_relative_path('colony/user_item')
  end
  autoload :Grid,                expand_relative_path('ants/grid')
  autoload :Utils,               expand_relative_path('ants/utils')

  extend self
  def test
    "Totally awesome test method!"
  end

  def parse_yml(file)
    hash = YAML.load(File.read(file))
    hash = rec_symbolize_keys(hash)
  end

  def parse_array_yml(file)
    File.read(file).squeeze("\n").split("---").map {|f| YAML.load(f) }.select {|x| x }
  end

private

  def rec_symbolize_keys(hash)
    hash.inject({}){|result, (key, value)|
      new_key         = key.is_a?(String) ? key.to_sym : key
      new_value       = value.is_a?(Hash) ? rec_symbolize_keys(value) : value
      result[new_key] = new_value
      result
    }
  end
end

# Entry point here
include Ants

simulation = Sims::Simulation.new
simulation.start

