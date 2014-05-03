class Ants::Grid

  attr_accessor :size, :surface, :ants, :items

  def initialize size, ants, items
    @size, @ants, @items = size, ants, items
    @surface = Array.new(size) { Array.new(size) }
    populate_grid
  end

  def type_at x, y
    surface[x][y].type
  rescue NoMethodError
    return 'E'
  end

  def [] x, y
    raise IndexError unless (x >= 0 && y >= 0)
    surface[x][y]
  end

  def []= x, y, item
    @surface[x][y] = item
  end

  def item? x, y
    surface[x % size][y % size].type == 'I'
  end

  def collision? x, y
    surface[x][y].type == 'A' || surface[x][y].type == 'B'
  end

  def set_item x, y
    item = self.items.select {|i| i.x == x && i.y == y}.first
    item.x, item.y = x, y
    @surface[x][y] = item
  end

  def get_item x, y
    self.items.select {|i| i.x == x && i.y == y}.first
  end

  def update_item item, x, y
    item.x, item.y = x, y
  end

  def set_entity x, y
    @surface[x][y] = Ants::Colony::Entity.new(x, y, self)
  end

  def neighbors item
    ns = []
    positions = [[-1,-1],[1,1]] \
              + [[0,1],[1,0]]   \
              + [[0,-1],[-1,0]] \
              + [[1,-1],[-1,1]]
    positions.each do |position|
      mod_x = (item.x + position[0]) % size
      mod_y = (item.y + position[1]) % size
      if item_at?(mod_x, mod_y)
        ns << self.items.select {|i| i.x == mod_x && i.y == mod_y}.first
      end
    end
    ns
  end

  def to_s
    # Include column indices
    string = "   "
    surface.each_index {|i| string += "#{i}#{' ' * (2-i.to_s.length)}" }
    string += "\n"

    surface.each_with_index do |row, i|
      # Include row index
      line = "#{i}#{' ' * (3 - i.to_s.length)}"
      row.each do |item|
        char = item.type == 'E' ? '. ' : colored_type(item)
        line << "#{char}"
      end
      string += "#{line}\n"
    end
    string += "\n"
    string
  end

private

  def item_at? x, y
    self.items.select {|i| i.x == x && i.y == y}.first
  end

  def populate_grid
    surface.each_with_index do |row, x|
      row.each_index do |y|
        self.surface[x][y] = Ants::Colony::Entity.new x, y, self
      end
    end
  end

  def colored_type item
    type = item.type
    color = case type
            when 'A'
              "red"
            when 'I'
              "green"
            when 'B'
              "blue"
            end
    color = "yellow" if item.respond_to?(:visited?) && item.visited?
    "#{type} ".send(color)
  end
end
