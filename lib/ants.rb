require "ants/version"
require 'yaml'

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

  def parse_yml(file)
    hash = YAML.load(File.read(file))
    hash = rec_symbolize_keys(hash)
  end

private

  def rec_symbolize_keys(hash)
    hash.inject({}){|result, (key, value)|
      new_key = case key
                when String then key.to_sym
                else key
                end
      new_value = case value
                  when Hash then rec_symbolize_keys(value)
                  else value
                  end
      result[new_key] = new_value
      result
    }
  end
end
