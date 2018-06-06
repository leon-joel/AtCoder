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

def main
  # N点     ※2<= N <= 100
  # x0 y0   ※0 <= x <= 100, 0 <= y <= 100
  # x1 y1
  #
  # 全探索の場合
  # N! 通り
  # 各通りで (x1 - x0)^2 + (y1 - y0)^2 の計算
  #
  # ざっくり 1億回≒1秒 なので、
  # この計算量だと全検索でも余裕
  #

  n = ARGF.gets.to_i

  points = []
  max_sqr_dist = 0
  n.times do |i|
    x, y = ARGF.gets.split.map(&:to_i)
    # puts "(#{x}, #{y})"
    p = Point.new(x, y)

    points.each do |p1|
      sqr_dist = p.calc_square_distance_to(p1)
      if max_sqr_dist < sqr_dist
        max_sqr_dist = sqr_dist
      end
    end

    points << p
  end
  puts Math.sqrt(max_sqr_dist)
end

if __FILE__ == $0
  main
end
