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

  def [](dangerous_i, dangerous_j)
    max_index = size()
    i = dangerous_i % max_index
    j = dangerous_j % max_index
    @rows.fetch(i){return nil}[j]
  end

  def []=(x, y, value = nil)
    @rows.fetch(x.to_i)[y.to_i] = value
  end

  def get(coords = {})
    pos = {x: 0, y: 0}.merge(coords)
    self[pos[:x], pos[:y]]
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

  def move(current, destination)
    current_object     = get(current)
    destination_object = get(destination)
    if current_object.kind_of?(Ants::Colony::Item) && destination_object.kind_of?(Ants::Colony::Item)
      raise "Cannot pile up items on the grid"
    end
    set(destination, current_object) unless destination_object.kind_of?(Ants::Colony::Item)
    current_object.position = destination
    set(current, nil)
  end

  def adjacent_sites(position)
    neighbors(position)
  end

  def neighbors(position, patchsize = 1)
    # Collect sites in a patch
    patchwidth = (patchsize * 2) + 1
    top_left   = {x: position[:x] - patchsize, y: position[:y] - patchsize}
    sites = []
    patchwidth.times do |x|
      patchwidth.times do |y|
        sites << {
          x: top_left[:x] + x,
          y: top_left[:y] + y
        }
      end
    end
    # Remove the centroid position
    sites.reject! {|site| site[:x] == position[:x] && site[:y] == position[:y]}
    # Mod the indices so they are 'safe'
    gridsize = size()
    sites.map! do |site|
      {
        x: site[:x] % gridsize,
        y: site[:y] % gridsize
      }
    end
  end

  def item_at?(position)
    get(position).kind_of? Ants::Colony::Item
  end

  def empty_at?(position)
    not item_at?(position)
  end

  def to_s
    string = ""
    @rows.each do |row|
      line = ""
      row.each do |value|
        line << "#{value.nil? ? '.' : value.print} "
      end
      string += "#{line}\n"
    end
    string
  end

end
