def rev(value)
  value.to_s.reverse.to_i
end

def process(x, y)
  y = rev(y)

  if x < y
    y = y - x
  else
    x = x - y
  end

  # 常に x >= y となるように入れ替える
  x, y = y, x if x < y
  [x, y]
end

# begin_x, begin_y は 常に x >= y となるように与えられる
# success: すでに条件を満たすことがわかっている(x,y)
def gojohou(org_xy, success, failed)
  xy = org_xy.clone
  xy_ary = []
  loop do
    if xy[0] < 10 || xy[1] < 10
      break
    end
    # break if x == 0 || y == 0

    # ループした？
    if xy_ary.find_index(xy)
      success << org_xy
      return true
    end

    xy_ary << xy

    # すでに条件を満たすことがわかっている？
    if success.find_index(xy)
      # success.concat(xy_ary)
      success << org_xy
      return true
    end

    # 条件を満たさないことがわかっている？
    if failed.find_index(xy)
      break
    end

    xy = process(*xy)
  end
  failed << org_xy
  false
end

def main
  lim_x, lim_y = ARGF.gets.split.map(&:to_i)

  cnt = 0

  # 10未満は調べない ※lim_xがbeginより下の場合は1度も回らない
  success = []
  failed = []
  10.upto(lim_y) do |y|
    10.upto(lim_x) do |x|
      xy = x < y ? [y, x] : [x, y]
      if success.find_index(xy)
        cnt += 1
        next
      end
      if failed.find_index(xy)
        next
      end
      if gojohou(xy, success, failed)
        cnt += 1
        next
      end
    end
  end

  puts cnt
end

if __FILE__ == $0
  main
end
