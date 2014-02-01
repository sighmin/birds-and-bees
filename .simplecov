require 'simplecov'
SimpleCov.start do
  # Code groupings
  add_filter '/spec/'
  add_group 'Algorithms',  'lib/algorithm'
  add_group 'Utilities',   'lib/ants'
  add_group 'Agents',      'lib/colony'
  add_group 'Simulations', 'lib/sims'
  # Simplecov config
  minimum_coverage 90
end

