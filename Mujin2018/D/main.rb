XY = Struct.new(:x, :y)

def rev(value)
  value.to_s.reverse.to_i
end

def process(xy)
  x = xy.x
  y = rev(xy.y)

  if x < y
    y = y - x
  else
    x = x - y
  end

  # 常に x >= y となるように入れ替える
  if x < y
    XY.new(y, x)
  else
    XY.new(x, y)
  end
end

# begin_x, begin_y は 常に x >= y となるように与えられる
# success: すでに条件を満たすことがわかっている(x,y)
def gojohou(org_xy, success, failed)
  xy = org_xy
  xy_ary = []
  loop do
    break if xy.x < 10 || xy.y < 10
    # break if x == 0 || y == 0

    # 失敗することがわかっている
    break if failed.find_index(xy)

    # すでに登場している？
    if xy_ary.find_index(xy)
      success << org_xy
      return true
    end

    xy_ary << xy

    # すでに条件を満たすことがわかっている？
    if success.find_index(xy)
      success << org_xy
      return true
    end

    xy = process(xy)
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
      xy = x < y ? XY.new(y, x) : XY.new(x, y)
      if success.find_index(xy)
        cnt += 1
        next
      end
      next if failed.find_index(xy)

      cnt += 1 if gojohou(xy, success, failed)
    end
  end

  puts cnt
end

if __FILE__ == $0
  main
end
