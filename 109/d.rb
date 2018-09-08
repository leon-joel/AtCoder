require 'pp'

def gets; ARGF.gets; end

class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def add(other)
    @x += other.x
    @y += other.y
    self
  end
  def +(other)
    Point.new(@x + other.x, @y + other.y)
  end
end

DIRS = [
    Point.new(1, 0),
    Point.new(0, 1),
    Point.new(-1, 0),
    Point.new(0, -1)
].freeze

class Grid
  attr_reader :h, :w
  attr_accessor :grid

  def initialize(h, w)
    @h = h
    @w = w
    @grid = []
    @dir = 0
    @lower_x = 0
    @upper_x = w-1
    @lower_y = 0
    @upper_y = h-1
  end

  def at(point)
    @grid[point.y][point.x]
  end

  def move(pos)
    # 方向チェック
    if @dir == 0 && pos.x == @upper_x
      @dir = 1
      @lower_y += 1
      return nil if @upper_y < @lower_y
    elsif @dir == 1 && pos.y == @upper_y
      @dir = 2
      @upper_x -= 1
      return nil if @upper_x < @lower_x
    elsif @dir == 2 && pos.x == 0
      @dir = 3
      @upper_y -= 1
      return nil if @upper_y < @lower_y
    elsif @dir == 3 && pos.y == 0
      @dir = 0
      @lower_x += 1
      return nil if @upper_x < @lower_x
    end

    # 移動
    pos + DIRS[@dir]
  end
end

def main
  h, w = gets.split.map(&:to_i)
  g = Grid.new(h, w)

  h.times do |r|
     g.grid << gets.split.map do |s|
       i = s.to_i
       i.odd? ? 1 : 0
     end
  end

  # スパイラルで回す
  pos = Point.new(0, 0)
  while true do
    if g.at(pos) == 0
      # 偶数だったら何もしない➾次のスパイラルに
      pos = g.move(pos)
      return if pos.nil?
    else
      # 次の奇数までスパイラルで移動する
      begin
        next_pos = g.move(pos)
        return if next_pos.nil?
        puts "#{pos.y} #{pos.x} #{next_pos.y} #{next_pos.x}"
        pos = next_pos
      end while g.at(pos) == 0
      pos = g.move(pos)
    end
  end

end

if __FILE__ == $0
  main
end
