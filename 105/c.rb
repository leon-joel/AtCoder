require 'pp'

def gets; ARGF.gets; end

Grade = Struct.new(:point, :num, :bonus) do
  def total
    point * num + bonus
  end

  # required点が与えられて、その点を取るために必要な問題数を返す
  # ただし、全問とかないと届かない場合や全問解いても届かない場合は0を返す
  def required_num(required)
    d = (required + point - 1) / point
    if d < num
      d
    else
      0
    end
  end
end

def main
  g_num, target = gets.split.map(&:to_i)
  grades = []
  g_num.times do |i|
    grades << Grade.new((i+1)*100, *gets.split.map(&:to_i))
  end
  # pp grades

  min_num = 1000

  # bit mask の生成
  0.upto((1 << g_num) - 1) do |mask|
    # 各bitを下から舐める
    total = 0
    num = 0
    0.upto(g_num-1) do |i|
      # ビットが立っている＝全問解く
      if mask[i] == 1
        total += grades[i].total
        num += grades[i].num
      end

      # すでにmin_num以上の問題を解いている？➾試行を続ける意味なし
      break if min_num < num
    end

    # 得点が足りている場合はここでmin_numを更新
    if target <= total
      min_num = num if num < min_num
      next
    end

    # まだ得点が足りていなかったら、解いていない一番下の問題を解く
    # それでも足りない場合、それは全問回答する組み合わせが不適切ということ
    rest = target - total
    (g_num-1).downto 0 do |i|
      # iビット目が立っていない＝まだ解いていない
      if mask[i] == 0
        added_num = grades[i].required_num(rest)
        if 0 < added_num
          num += added_num
          min_num = num if num < min_num
        end
        break
      end
    end
  end

  puts min_num
end

if __FILE__ == $0
  main
end
