class Ants::Grid

  attr_accessor :size

  def initialize size
    @size = size
    @surface = Array.new(size) { Array.new(size) }
    populate_grid
  end

  def type_at x, y
    @surface[x][y].type
  rescue NoMethodError
    return 'E'
  end

  def [](x, y)
    raise IndexError unless (x > -1 && y > -1)
    @surface[x][y]
  end

  def []=(x, y, item)
    @surface[x][y] = item
  end

  def to_s
    string = ''
    @surface.each do |row|
      line = ''
      row.each do |item|
        char = item.type == 'E' ? '. ' : colored_type(item.type)
        line << "#{char}"
      end
      string += "#{line}\n"
    end
    string += "\n"
    string
  end

private

  def populate_grid
    @surface.each_with_index do |row, x|
      row.each_index do |y|
        self[x,y] = Ants::Colony::Entity.new(x, y, self)
      end
    end
  end

  def colored_type type
    color = case type
            when 'A'
              "red"
            when 'I'
              "green"
            when 'B'
              "blue"
            end
    "#{type} ".send(color)
  end
end
