class Ants::Colony::UserItem < Ants::Colony::Item

  def self.pickup_probability(item, neighbors)
    ( @@lambda1/(@@lamba1 + dissimilarity(item, neighbors)) ) ** 2
  end

  def self.drop_probability(item, neighbors)
    dissimilarity_index = dissimilarity(item, neighbors)
    if dissimilarity_index < @@lambda2
      2 * dissimilarity_index
    else # >= @@lambda2
      1
    end
  end

protected

  def self.dissimilarity(item, neighbors)
    0.1
  end
end
