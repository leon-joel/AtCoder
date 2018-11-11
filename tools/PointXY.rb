class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end
  def to_s
    "(#{x},#{y})"
  end
  def calc_square_distance_to(point)
    (point.x - @x)**2 + (point.y - @y)**2
  end
end

class XY
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end
  def to_s
    "(#{@x},#{@y})"
  end
  def ==(other)
    @x == other.x && @y == other.y
  end
  def eql?(other)
    self.==(other)
  end
  def +(other)
    XY.new(@x + other.x, @y + other.y)
  end
end

XY = Struct.new(:x, :y) do
  def calc_square_distance_to(point)
    (point.x - x)**2 + (point.y - y)**2
  end
end