# bit DPのサンプル
# ARC061 C問題より
# https://arc061.contest.atcoder.jp/tasks/arc061_a

def main
  s = ARGF.gets.chomp

  # + を入れられる場所の数
  n = s.length - 1

  sum = 0
  # bit mask の生成
  # 2^n     = 1 << n
  0.upto((1 << n) - 1) do |mask|
    last_idx = 0

    # 各bitを下から舐める
    0.upto(n-1) do |i|

      # iビット目が立っているかどうか
      if mask[i] == 1
        # '+'を i番目 と i+1番目の間に入れる
        part = s.slice(last_idx, i - last_idx + 1)
        # puts part
        sum += part.to_i
        last_idx = i+1
      end
    end
    # 残り全部
    last_part = s.slice(last_idx..-1)
    # puts last_part
    sum += last_part.to_i
  end

  puts sum
end

if __FILE__ == $0
  main
end
