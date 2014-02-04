# Compare by calculating % of common interests
# This would typically be produced by some predictive model (trained NN)

class Ants::Colony::UserItem < Ants::Colony::Item

  def dissimilarity(foreign)
    item_interests = self.data[:interests]
    foreign_interests = foreign.data[:interests]
    item_num_interests = count_interests_in_hash(item_interests)
    foreign_num_interests = count_interests_in_hash(foreign_interests)

    num_similar = 0
    item_interests.each do |k, v|
      num_similar += count_identical_in_arr(v, foreign_interests[k])
    end

    num_similar.to_f / [item_num_interests, foreign_num_interests].min.to_f
  end

protected

  def count_interests_in_hash(interests)
    count = 0
    interests.each do |k,v|
      count += v.length
    end
    count
  end

  def count_identical_in_arr(arr1, arr2)
    composite_arr = arr1 + arr2
    composite_arr.length - composite_arr.uniq.length
  end

end
