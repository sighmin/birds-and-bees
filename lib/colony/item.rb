class Ants::Colony::Item

  attr_accessor :x, :y, :data

  def initialize(position = {x: 0, y: 0}, data = nil)
    @x    = position[:x]
    @y    = position[:y]
    @data = data

    @@lambda        = 1.0
    @@lambda_pickup = 1.0
    @@lambda_drop   = 1.0
  end

  def position
    {x: @x, y: @y}
  end

  def position=(position)
    @x = position[:x]
    @y = position[:y]
  end

  def print
    "O"
  end

  def self.pickup_probability(item, neighbors, patchsize)
    ( @@lambda_pickup/(@@lamba_pickup + local_density(item, neighbors)) ) ** 2
  end

  def self.drop_probability(item, neighbors, patchsize)
    density = local_density(item, neighbors)
    if density < @@lambda_drop
      2 * density
    else # >= @@lambda2
      1
    end
  end

protected

  def self.local_density(item, neighbors, patchsize)
    inverse_patch_squared = 1.0 / (patchsize ** 2)
    sum_similarity = 0.0
    neighbors.each do |foreign|
      sum_similarity += (1.0 - (dissimilarity(item, foreign)/@@lamba))
    end
    average_similarity = inverse_patch_squared * sum_similarity
    [0.0, average_similarity].max
  end

  def self.dissimilarity(item, foreign)
    raise "NotOverridedInSubclassException"
  end
end

