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
# fails: すでに条件を満たさないことがわかっている
def gojohou(bx, by, success, fails)
  xy = [bx, by]
  xy_ary = []
  loop do
    # すでに失敗することがわかっている？
    break if fails.include?(xy)

    # すでに登場している？
    if xy_ary.find_index(xy)
      success.merge(xy_ary)
      return true
    end

    # すでに条件を満たすことがわかっている？
    if success.include?(xy)
      success.merge(xy_ary)
      return true
    end

    # 未知の組み合わせだった
    xy_ary << xy

    xy = process(*xy)
    break if xy[0] < 10 || xy[1] < 10
  end
  fails.merge(xy_ary)
  false
end

def main
  lim_x, lim_y = ARGF.gets.split.map(&:to_i)
  lim_x, lim_y = lim_y, lim_x if lim_x < lim_y

  cnt = 0

  # 10未満は調べない ※lim_xがbeginより下の場合は1度も回らない
  success = Set.new
  fails = Set.new
  10.upto(lim_y) do |y|
    y.upto(lim_x) do |x|
      if success.include?([x, y])
        cnt += 1
        next
      end

      cnt += 1 if gojohou(x, y, success, fails)
    end
  end

  puts cnt
end

if __FILE__ == $0
  main
end
