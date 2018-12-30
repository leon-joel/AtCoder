class BIT
  attr_reader :bit

  # 1〜n の個数を管理する
  def initialize(n)
    @n = n
    @bit = Array.new(@n + 1, 0)
  end

  # i の個数を x 増加
  # ★i は1以上
  def add(i, x)
    # i += 1
    while i <= @n
      @bit[i] += x
      i += i & -i
    end
  end

  # i 以下の総数を返す
  # ※0以下のi を与えた場合は0を返す
  def sum(i)
    s = 0
    while 0 < i
      s +=  @bit[i]
      i -= i & -i
    end
    s
  end

  # [lower, upper] つまり lower以上 upper以下 の総数を返す
  def range_sum(lower, upper)
    sum(upper) - sum(lower-1)
  end

  # i の個数を返す
  def count(i)
    sum(i) - sum(i-1)
  end
end

# Chokudai SpeedRun001 - J: 転倒数
# https://atcoder.jp/contests/chokudai_s001/tasks/chokudai_S001_j
def gets; ARGF.gets; end
class Solver
  def main
    n = gets.chomp.to_i
    nums = gets.split.map(&:to_i)

    # 1〜N の数列に出現する各数字をカウント
    bit = BIT.new(n)

    ans = 0
    n.times do |i|
      # ans += これまでに出現した数字の総数 - 自分以下のカウント
      # これすなわち、自分の左側に現れた自分より大きい数字の総数 となる
      ans += i - bit.sum(nums[i])

      # 自分の数字をカウントアップ
      bit.add(nums[i], 1)
    end

    puts ans
  end
end

if __FILE__ == $0
  Solver.new.main
end
