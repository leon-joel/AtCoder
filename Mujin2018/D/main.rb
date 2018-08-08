def rev(value)
  value.to_s.reverse.to_i
end

def process(x, y)
  if x < y
    x = rev(x)
  else
    y = rev(y)
  end

  if x < y
    y = y - x
  else
    x = x - y
  end

  # 常に x >= y となるように入れ替える
  x, y = y, x if x < y
  [x, y]
end

# grid: nil=未調査 1=OK  0:NG
def gojohou(bx, by, grid)
  ox, oy = bx, by
  ox, oy = oy, ox if ox < oy
  x, y = ox, oy
  xy_ary = []
  loop do
    if x < 10 || y < 10
      break
    end
    # break if x == 0 || y == 0

    # ループした？
    if xy_ary.find_index([x, y])
      grid.set(ox, oy, 1)
      return true
    end

    xy_ary << [x, y]

    v = grid.get(x, y)
    if !v.nil?
      # すでに条件を満たすことがわかっている？
      if v == 1
        return true
      end

      # 条件を満たさないことがわかっている？
      if v == 0
        break
      end
    end

    x, y = process(x, y)
  end
  grid.set(ox, oy, 0)
  false
end

class Grid
  def initialize(sx, sy)
    @grid = Array.new(1000) { Array.new(1000) }
  end
  def set(x, y, value)
    @grid[x][y] = value
  end
  def get(x, y)
    @grid[x][y]
  end
end

def main
  lim_x, lim_y = ARGF.gets.split.map(&:to_i)

  cnt = 0

  # success, fail を表す grid map を作る
  grid = Grid.new(1000, 1000)
  # 10未満は調べない ※lim_xがbeginより下の場合は1度も回らない
  10.upto(lim_y) do |y|
    10.upto(lim_x) do |x|
      if gojohou(x, y, grid)
        cnt += 1
      end
    end
  end

  puts cnt
end

if __FILE__ == $0
  main
end
