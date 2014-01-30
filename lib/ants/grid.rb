class Ants::Grid < Matrix

  def sample
    pos = sample_position()
    self[pos[:x], pos[:y]]
  end

  def sample_position
    rx = Ants::Utils.random(size())
    ry = Ants::Utils.random(size())
    {x: rx, y: ry}
  end

  def sample_nil_position
    num_positions = size()**2
    num_positions.times do
      pos = sample_position
      return pos if self[pos[:x], pos[:y]].nil?
    end
    raise "YouNeedToFixThisSimonError"
  end

  def []=(x, y, value = nil)
    @rows.fetch(x)[y] = value
  end

  def set(coords = {}, value = nil)
    pos = {x: 0, y: 0}.merge(coords)
    self[pos[:x], pos[:y]] = value
  end

  def place(array)
    array.each {|e| self.set(e.position, e)}
  end

  def size
    @rows.fetch(0).length
  end

  def to_s
    @rows.each do |row|
      line = ""
      row.each do |value|
        line << "#{value.nil? ? '.' : value.print} "
      end
      puts line
    end
  end

end
