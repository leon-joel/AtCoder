class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def calc_square_distance_to(point)
    (point.x - @x)**2 + (point.y - @y)**2
  end
end

XY = Struct.new(:x, :y) do
  def calc_square_distance_to(point)
    (point.x - x)**2 + (point.y - y)**2
  end
end