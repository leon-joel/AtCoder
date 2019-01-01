require 'pp'

def gets; ARGF.gets; end

# Strange Bank
# https://atcoder.jp/contests/abc099/tasks/abc099_c

# 個数制限なしナップサックDP
class KnapsackDPSolver
  def main
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
              # 引き出し金額が 6円, 9円, 1円 の順にDPした場合の例
              # ※空欄はINF
              #   w->0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 ...
              # 0    0                                              ...
              # 6    0           1              2                 3 ...
              # 9    0           1     1        2                 2 ...
              # 1    0 1 2 3 4 5 1 2 3 1  2  3  2  3  4  5  6  7  2 ...
            end
      end
      # pp "#{i+1}: #{dp[i+1]}"
    end

    puts dp[n][upper_w]
  end
end

# メモ探索（＝再帰関数のメモ化）での実装
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
