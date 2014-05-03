class Ants::Colony::UserItem < Colony::Item

  attr_accessor :data

  def initialize grid, data, x = nil, y = nil
    super grid, x, y
    @data = data
  end

  # d(xi,xj) = (p-m)/p
  # where p is num interests, m is num matches
  def similarity_index foreign
    item_interests = self.data[:interests]
    foreign_interests = foreign.data[:interests]
    p = [count_interests_in_hash(item_interests), count_interests_in_hash(foreign_interests)].min.to_f

    m = 0.0
    item_interests.each do |k, v|
      m += count_identical_in_arr(v, foreign_interests[k])
    end

    #(p-m)/p
    m/p
  end

private

  def count_interests_in_hash interests
    count = 0
    interests.each do |k,v|
      count += v.length
    end
    count
  end

  def count_identical_in_arr arr1, arr2
    composite_arr = arr1 + arr2
    composite_arr.length - composite_arr.uniq.length
  end
end
