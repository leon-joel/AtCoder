XY = Struct.new(:x, :y) do
  def calc_square_distance_to(point)
    (point.x - x)**2 + (point.y - y)**2
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

  _ = ARGF.gets.chomp.to_i

  max_sqr_dist = 0
  points = []
  while s = ARGF.gets
    point = XY.new(*s.split.map(&:to_i))

    points.each do |p|
      sqr_dist = point.calc_square_distance_to(p)
      if max_sqr_dist < sqr_dist
        max_sqr_dist = sqr_dist
      end
    end

    points << point
  end

  puts Math.sqrt max_sqr_dist
end

if __FILE__ == $0
  main
end
