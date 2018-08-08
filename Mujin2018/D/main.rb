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
  # x, y = y, x if x < y
  [x, y]
end

# grid: nil=未調査 1=OK  0:NG
def gojohou(bx, by, grid)
  x = bx
  y = by
  xy_ary = []
  loop do
    if x < 10 || y < 10
      break
    end
    # break if x == 0 || y == 0

    # ループした？
    if xy_ary.find_index([x, y])
      return true
    end

    xy_ary << [x, y]

    # すでに条件を満たすことがわかっている？
    v = grid[x][y]
    if !v.nil?
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
  # failed << org_xy
  false
end

def main
  lim_x, lim_y = ARGF.gets.split.map(&:to_i)

  cnt = 0

  # success, fail を表す grid map を作る
  grid = Array.new(1000) { Array.new(1000) }
  # 10未満は調べない ※lim_xがbeginより下の場合は1度も回らない
  10.upto(lim_y) do |y|
    10.upto(lim_x) do |x|
      if gojohou(x, y, grid)
        grid[x][y] = 1
        cnt += 1
      else
        grid[x][y] = 0
      end
    end
  end

  puts cnt
end

if __FILE__ == $0
  main
end
