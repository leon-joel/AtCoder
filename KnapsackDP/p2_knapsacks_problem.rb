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

class Solver
  def main
    # 問題2: ナップサック問題
    # https://qiita.com/drken/items/a5e6fe22863b7992efdb
    # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DPL_1_B&lang=jp

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

if __FILE__ == $0
  Solver.new.main
end
