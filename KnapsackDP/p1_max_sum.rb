require 'pp'

def gets; ARGF.gets; end

class Solver
  def main
    # 問題1: 最大和問題
    # https://qiita.com/drken/items/a5e6fe22863b7992efdb
    n = gets.chomp.to_i
    knapsacks = gets.split.map(&:to_i)

    # 非DP解法 - 正の数の和をとっているだけ
    # ans = knapsacks.inject(0) do |sum, i|
    #   if 0 < i
    #     sum + i
    #   else
    #     sum
    #   end
    # end
    #
    # puts ans

    # ナップサックDPによる解法
    # dp[i] = v
    #   i番目(1〜)まで選んだ（pickするかしないかを決定した）場合の
    #   最大値が v
    dp = Array.new(n+1)

    # 初期状態をセット
    dp[0] = 0

    0.upto(n-1) do |i|
      # ここで、i番目（1〜）のナップサックを
      # pickするかしないかを選択している
      dp[i+1] = [dp[i], dp[i] + knapsacks[i]].max
    end

    puts dp[n]
  end
end

if __FILE__ == $0
  Solver.new.main
end
