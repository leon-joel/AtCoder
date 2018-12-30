require 'pp'

def gets; ARGF.gets; end

# 32bit整数
INT_MAX = 2147483647
UINT_MAX = 4294967295
# 64bit整数
LONGLONG_MAX = 9223372036854775807
ULONGLONG_MAX = 18446744073709551615

class Solver
  def main
    n, k = gets.split.map(&:to_i)

    # 区間（キャンドル本数）固定して全探索
    min_dist = ULONGLONG_MAX
    candles = gets.split.map(&:to_i)
    (k-1).upto(n-1) do |i|
      r_pos = candles[i]
      l_pos = candles[i - (k - 1)]
      r_dist = r_pos.abs
      l_dist = l_pos.abs

      # 両端のキャンドル間の距離は必ず歩くので
      dist = r_pos - l_pos

      # 0に近い方の端までの距離を加算
      if r_dist <= l_dist
        # 右端のほうが近い
        dist += r_dist
      else
        dist += l_dist
      end

      min_dist = dist if dist < min_dist
    end

    puts min_dist
  end
end

if __FILE__ == $0
  Solver.new.main
end
