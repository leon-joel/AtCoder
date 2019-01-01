require 'pp'

def gets; ARGF.gets; end

# Strange Bank
# https://atcoder.jp/contests/abc099/tasks/abc099_c

def scan_input
  upper_w = gets.chomp.to_i

  # 品物（引き出し単位金額）のリストを生成
  items = []
  w = 1
  while w <= upper_w
    items << w
    w *= 6
  end
  w = 9
  while w <= upper_w
    items << w
    w *= 9
  end
  # pp items

  [upper_w, items]
end

# 個数制限なしナップサックDP
class KnapsackDPSolver
  def main
    upper_w, items = scan_input

    n = items.length

    # 金額wを引き出すのに必要な最小の回数を格納
    # dp[i][w] = v
    # ★【最小の】回数を格納するので初期値はINF的な値に
    dp = Array.new(n+1) { Array.new(upper_w+1, 1 << 29) }
    # ★左端を全部0に。0円は0回で引き出せるので。
    0.upto(n) do |i|
      dp[i][0] = 0
    end

    0.upto(n-1) do |i|
      0.upto(upper_w) do |w|
        dp[i+1][w] =
            if w < items[i]
              # 現在の重さより左側は現在のアイテム（金額）を使えないので
              # 上から下ろす or 既に有る値
              [dp[i][w], dp[i+1][w]].min
            else
              # 現在の重さ以上の部分（右側）は
              # 重さ分左のvalue + 現在value or 下ろすだけ
              [dp[i+1][w - items[i]] + 1, dp[i][w]].min
              # 引き出し金額が 1円, 6円, 9円 の順にDPした場合の例
              # ※空欄はINF
              #   w->0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 ...
              # 0    0                                              ...
              # 1    0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 ...
              # 6    0 1 2 3 4 5 1 2 3 4  5  6  2  3  4  5  6  7  3 ...
              # 9    0 1 2 3 4 5 1 2 3 1  2  3  2  3  4  2  3  4  2 ...
            end
      end
      # pp "#{i+1}: #{dp[i+1]}"
    end

    puts dp[n][upper_w]
  end
end

# 個数制限なしナップサックDP
# ★1次元DP配列で実装するパターン
class KnapsackDPSolver2
  def main
    upper_w, items = scan_input

    n = items.length

    # 金額wを引き出すのに必要な最小の回数を格納
    # dp[w] = v
    # ★【最小の】回数を格納するので初期値はINF的な値に
    dp = Array.new(upper_w+1, 1 << 29)
    # 左端は0に。0円は0回で引き出せるので。
    dp[0] = 0

    0.upto(n-1) do |i|
      # DPテーブルが2次元の場合と違い、
      # 現在金額より左側の部分（現在金額が使えない部分）をただ下に下ろすだけの処理が必要なくなるので、
      # ループの開始を現在金額にする
      items[i].upto(upper_w) do |w|
        dp[w] = [dp[w], dp[w - items[i]] + 1].min
      end
    end

    puts dp[upper_w]
  end
end

# メモ探索風（＝再帰関数のメモ化）での実装
# ★Qiitaに載っている実装だとStackLevelTooDeepになってしまう。
#   （1円引き出すたびに再帰が入るので…。C++だと大丈夫のようだ。）
#   理論的な裏付けはないが、この実装では6/9各シリーズのrest内最大金額だけを探索するようにした。
class MemoizeRecursive
  SIXES = [1, 6, 36, 216, 1296, 7776, 46656].freeze
  NINES = [1, 9, 81, 729, 6561, 59049].freeze

  def main
    @upper_w = gets.chomp.to_i

    @memo = Array.new(@upper_w+1)

    ans = recurse(@upper_w)
    puts ans
  end

  def recurse(rest)
    return rest if rest < 6

    # 既に計算済みの場合はそれを返す
    return @memo[rest] unless @memo[rest].nil?

    # 6円シリーズのrest内最大金額と9円シリーズのrest内最大金額を試す
    result = @upper_w

    w = SIXES.select{|i| i <= rest}.max
    result = [recurse(rest - w) + 1, result].min

    w = NINES.select{|i| i <= rest}.max
    result = [recurse(rest - w) + 1, result].min

    @memo[rest] = result
  end
end

if __FILE__ == $0
  # KnapsackDPSolver.new.main
  # KnapsackDPSolver2.new.main
  MemoizeRecursive.new.main
end
