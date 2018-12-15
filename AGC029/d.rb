require 'pp'

def gets; ARGF.gets; end

def main
  # 原点(0, 0)
  # (j, i) →j,x高橋, ↓i,Y青木 として考える
  h, w, n = gets.split.map(&:to_i)

  # 高橋君は動けるときは必ず動かないといけない

  # 障害物がない場合、ans == w となる ※青木は一切動かないので

  # x <= y の障害物は無視 ※決してたどり着けないので

  # w <= x の障害物も無視 ※これらの障害物に行くよりは外壁に向かったほうがいいので
  # あ、こんな障害物存在し得ないんだった^^; （原点0,0で考えた場合）

  # その中で最も x が小さいものを見つければよい
  # ans は【当該障害物の x 座標】となる

  # だめだった！

  # x <= y は無視
  #
  # x で昇順ソート
  #
  # x - y を diff と定義

  # 最初に diff == 1 となる障害物がゴール
  # ただし、その前に diff == 0 となる障害物が見つかった場合、
  # diff += 1 する
  #
  # 以下同じで、diff == 2 となる障害物がゴールだが、
  # diff == 1 となる障害物が見つかった場合は
  # 更に diff += 1 する

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
    if x - y == diff
      return puts x
    elsif (x - y) == (diff - 1)
      diff += 1
    end
  end
  puts w
end

if __FILE__ == $0
  main
end
