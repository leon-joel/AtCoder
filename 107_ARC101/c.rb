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

      if r_pos <= 0
        # 全部負の位置
        min_dist = l_dist if l_dist < min_dist
      elsif 0 <= l_pos
        # 全部正の位置
        min_dist = r_dist if r_dist < min_dist
      else
        # 0またぎ
        if 0 < r_pos + l_pos
          # 右のほうが遠い
          d = l_dist * 2 + r_dist
        else
          # 左のほうが遠い
          d = r_dist * 2 + l_dist
        end
        min_dist = d if d < min_dist
      end
    end

    puts min_dist
  end
end

if __FILE__ == $0
  Solver.new.main
end
