require 'pp'

def gets; ARGF.gets; end

def main
  s = gets.chomp

  # bit全探索
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
        sum += part.to_i
        last_idx = i+1
      end
    end
    # 残り全部
    sum += s.slice(last_idx..-1).to_i
  end
  puts sum
end

if __FILE__ == $0
  main
end
