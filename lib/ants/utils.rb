module Ants::Utils

  @@random = Random.new

  def random arg = 1.0
    @@random.rand arg
  end

  extend self
end
