require 'pp'

def gets; ARGF.gets; end

def main
  h, w, n = gets.split.map(&:to_i)

  # 高橋君は動けるときは必ず動かないといけない

  # 障害物がない場合、ans == w となる ※青木は一切動かず壁まで到達

  # x < y の障害物は無視 ※決してたどり着けないので

  # x で昇順ソート
  #
  # x - y を diff と定義
  # min_diff = 1
  #
  # 最初に 1 <= diff となる障害物がゴール
  # ただし、その前に diff == 0 となる障害物が見つかった場合、
  # min_diff を1加算 する
  #
  # 以下同じで、min_diff <= diff となる障害物がゴールだが、
  # diff == min_diff-1 となる障害物が見つかった場合は
  # 更に min_diff += 1 する

  o_ary = []
  n.times do
    # 原点(0, 0)に変換
    x, y = gets.split.map do |c|
      c.to_i - 1
    end

    # x < y は無視
    next if x < y

    o_ary << [x, y]
  end

  o_ary.sort!
  # pp o_ary

  diff = 1
  o_ary.each do |(x, y)|
    if (x - y) == (diff - 1)
      # 青木くんの行動を制限するブロック
      diff += 1

    elsif diff <= x - y
      # 目標ブロックに到達
      return puts x
    end
  end
  puts h
end

if __FILE__ == $0
  main
end
