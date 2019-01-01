require 'pp'

def gets; ARGF.gets; end

class VW
  attr_reader :value, :weight
  def initialize(value, weight)
    @value = value
    @weight = weight
  end
  def to_s
    "V:#{@value} W:#{@weight}"
  end
end

# 問題2: ナップサック問題
# https://qiita.com/drken/items/a5e6fe22863b7992efdb
# http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DPL_1_B&lang=jp

# ナップサックDP（漸化式）での実装
class KnapsackDPSolver
  def main

    n, upper_w = gets.split.map(&:to_i)

    ks = Array.new(n)
    n.times do |i|
      # [Value, Weight]
      ks[i] = VW.new(*gets.split.map(&:to_i))
    end
    # pp knapsacks

    # 重さwで運べる最大の価値を格納
    # dp[i][w] = v
    # dp[0] : 初期条件
    dp = Array.new(n+1) { Array.new(upper_w+1, 0) }
    dp[0] = Array.new(upper_w+1, 0)

    0.upto(n-1) do |i|
      item = ks[i]
      0.upto(upper_w) do |w|
        dp[i+1][w] =
            if w < item.weight
              # 現在の重さより左側は上から下ろしてくるだけ
              dp[i][w]
            else
              # 現在の重さ以上の部分（右側）は
              # 重さ分左のvalue + 現在value or 下ろすだけ
              [dp[i][w - item.weight] + item.value, dp[i][w]].max
            end
      end
      # pp "#{i+1}: #{dp[i+1]}"
    end

    puts dp[n][upper_w]
  end
end

# メモ化再帰での実装
# https://www.slideshare.net/iwiwi/ss-3578511
class MemoizeRecursive
  def main
    @n, upper_w = gets.split.map(&:to_i)

    @ks = Array.new(@n)
    @n.times do |i|
      # [Value, Weight]
      @ks[i] = VW.new(*gets.split.map(&:to_i))
    end
    # pp knapsacks

    # @memoの方でdoneを兼ねられるので省略
    # @done = Array.new(@n) { Array.new(upper_w+1, false) }
    # 既に求めた最大価値を格納（未計算はnil）
    @memo = Array.new(@n) { Array.new(upper_w+1) }

    ans = search(0, upper_w)
    puts ans

    # pp @memo
  end

  def search(i, upper_w)
    return 0 if @n <= i

    # 既に計算済みの場合はそれを返す
    # return @memo[i][upper_w] if @done[i][upper_w]
    return @memo[i][upper_w] unless @memo[i][upper_w].nil?

    item = @ks[i]
    # この品物は入らないので次に進む
    return search(i+1, upper_w) if upper_w < item.weight

    # この品物を入れない場合と入れる場合の両方で探索
    value1 = search(i+1, upper_w)
    value2 = search(i+1, upper_w - @ks[i].weight) + @ks[i].value
    value = [value1, value2].max
    # @done[i][upper_w] = true
    @memo[i][upper_w] = value
    value
  end
end

# 参考:同じ問題を全探索で解く実装
# https://www.slideshare.net/iwiwi/ss-3578511
# これだと200品目でも終わらない O(2^n)
class AllSearchSolver
  def main
    @n, upper_w = gets.split.map(&:to_i)

    @ks = Array.new(@n)
    @n.times do |i|
      # [Value, Weight]
      @ks[i] = VW.new(*gets.split.map(&:to_i))
    end
    # pp knapsacks

    ans = search(0, upper_w)
    puts ans
  end

  # i番目以降の品物で重さの総和がupper以下になる
  # 最大の価値を返す
  def search(i, upper_w)
    # 品物が残ってない
    return 0 if @n <= i

    if upper_w < @ks[i].weight
      # もうこの品物は入らない
      return search(i+1, upper_w)
    end

    # この品物を入れない場合と入れる場合の両方で探索
    value1 = search(i+1, upper_w)
    value2 = search(i+1, upper_w - @ks[i].weight) + @ks[i].value
    [value1, value2].max
  end
end

if __FILE__ == $0
  KnapsackDPSolver.new.main
end
