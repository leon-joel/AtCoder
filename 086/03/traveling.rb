n = gets.to_i

# 前に存在していた点
lx = ly = 0
# 前に存在していた点にいた時刻
lt = 0
# 合否
is_enable = true

n.times do
  t, x, y = gets.split.map(&:to_i)
  if !is_enable
    next  # 既にNGだとわかっているので読み飛ばすだけ ※最後まで読み込まないとAtCoderではRuntimeErrorになる
  end

  # 前に存在していた点からの距離（道のり）
  distance = (x - lx).abs + (y - ly).abs

  # 前に存在していた点にいた時刻からの経過時刻
  dt = t - lt

  if dt < distance
    is_enable = false
    next
  end

  # 経過時刻が偶数なら距離も偶数じゃなければならない。奇数でも同様。
  if dt.even? != distance.even?
    is_enable = false
    next
  end

  lt = t
  lx = x
  ly = y
end

puts (is_enable ? 'Yes' : 'No')
