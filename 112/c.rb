require 'pp'

def gets; ARGF.gets; end

def dist(x0, y0, x1, y1)
  (x0 - x1).abs + (y0 - y1).abs
end

# 中心点ならその高さを返す。違うならnilを返す
def judge(cx, cy, ch, points)
  points.each do |(h, x, y)|
    d = dist(cx, cy, x, y)
    if ch.nil?
      ch = h + d
    elsif 0 < h
      if ch != h + d
        return nil
      end
    else
      if d < ch
        return nil
      end
    end
  end
  ch
end

def puts_ans(x, y, h)
  puts "#{x} #{y} #{h}"
end
MAX_INDEX = 100

def main
  n = gets.chomp.to_i

  grid = Array.new(MAX_INDEX+1) {Array.new(MAX_INDEX+1)}

  points = []
  n.times do |i|
    x, y, h = gets.split.map(&:to_i)
    grid[x][y] = h

    # 調査点情報は配列に入れておく
    points << [h, x, y]
  end
  # h=0 を後ろに追いやっておく
  points.sort!
  points.reverse!

  # グリッドの全セルをなめて、中心条件を満たすものを探す
  0.upto(MAX_INDEX) do |x|
    line = grid[x]
    0.upto(MAX_INDEX) do |y|
      h = line[y]
      next if h == 0

      ch = judge(x, y, h, points)
      if !ch.nil?
        puts_ans(x, y, ch)
        return
      end

    end

  end
  puts "ERROR"
end

if __FILE__ == $0
  main
end
