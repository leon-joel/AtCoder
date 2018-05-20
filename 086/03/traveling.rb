def main
  # n = $stdin.gets.to_i
  # ↑rspec側で$stdinをすげ替えているので明示的にそれを読み込ませる
  #   ただし、このようにしてしまうとスクリプト引数に入力ファイルを指定してもそれを読み込んではくれなくなる。
  n = ARGF.gets.to_i
  # ↑rspec側でARGFをStringIOに置き換えれば、specも正しく動作する上に、
  #   通常実行時 標準入力からの入力でも、入力ファイルからの入力でも正しく動作する。
  puts("Error") if n <= 0

  # 前に存在していた点
  lx = ly = 0
  # 前に存在していた点にいた時刻
  lt = 0

  n.times do
    t, x, y = ARGF.gets.split.map(&:to_i)

    # 前に存在していた点からの距離（道のり）
    distance = (x - lx).abs + (y - ly).abs

    # 前に存在していた点にいた時刻からの経過時刻
    dt = t - lt

    if dt < distance
      puts 'No'
      return    # 入力をgetsするのを途中でやめても大丈夫かな？
    end

    # 経過時刻が偶数なら距離も偶数じゃなければならない。奇数でも同様。
    if dt.even? != distance.even?
      puts 'No'
      return
    end

    lt = t
    lx = x
    ly = y
  end

  puts 'Yes'
end

if __FILE__ == $0
  main
end
