require 'pp'

def gets; ARGF.gets; end

class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end
  def to_s
    "(#{x},#{y})"
  end

  def dist_from_origin
    x.abs + y.abs
  end

  # 腕を減算し、その腕の方向を返す
  def sub_len(len)
    x_abs = @x.abs
    y_abs = @y.abs
    if y_abs <= x_abs
      if 0 <= @x
        @x -= len
        "R"
      else
        @x += len
        "L"
      end
    else
      if 0 <= @y
        @y -= len
        "U"
      else
        @y += len
        "D"
      end
    end
  end
end

def calc_arms(dist)
  arms = []
  # 偶数は面倒なので最初に1引いておく
  arms << 1 if dist.even?
  dist -= 1

  # armは [1, 2, 4, ..., longest_arm] を取り揃える。
  #   dist = longest_arm * 2 - 1
  # までは届く。
  # 最初に追加した1を加えると,
  #   dist = longest_arm * 2
  # まで届く。
  longest_arm = 1
  arms << 1
  while true
    next_arm = longest_arm * 2
    break if dist < next_arm

    longest_arm = next_arm
    arms << longest_arm
  end
  arms
end

def main
  n = gets.chomp.to_i

  is_odd = nil  # 偶数奇数チェック ※すべての距離が偶数 or 奇数 で揃っていないとNG
  max_dist = 0  # 原点からの最長距離
  points = Array.new(n)
  n.times do |i|
    xy = Point.new *gets.split.map(&:to_i)
    dist = xy.dist_from_origin
    max_dist = dist if max_dist < dist
    if is_odd.nil?
      is_odd = dist.odd?
    elsif is_odd != dist.odd?
      puts "-1"
      return
    end

    points[i] = xy
  end
  # puts points

  # armセットを作り上げる
  arms = calc_arms(max_dist).reverse
  puts arms.length
  puts arms.join(" ")

  # 問題を解いていく
  points.each do |p|
    arm_dirs = []

    arms.each do |arm|
      arm_dirs << p.sub_len(arm)
    end

    puts arm_dirs.join
  end
end

if __FILE__ == $0
  main
end
