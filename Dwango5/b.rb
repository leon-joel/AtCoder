require 'pp'

def gets; ARGF.gets; end

def main
  n, k = gets.split.map(&:to_i)
  nums = gets.split.map(&:to_i)
  # puts nums

  # 美しさ（各部分列の合計）の配列を作る
  # 部分列数
  p_num = n * (n + 1) / 2
  # 部分列の美しさ配列
  b_ary = Array.new(p_num)
  i = 0
  0.upto(nums.length-1) do |l|
    # 先頭を1つずつずらしていく
    p_sum = 0
    (nums.length-l).times do |dist|
      # 先頭からの合計を加算しながら、美しさ配列に入れていく
      p_sum += nums[l+dist]
      b_ary[i] = p_sum
      i += 1
    end
  end
  # puts b_ary

  # 上位ビットから確認（最大40digits）
  prefix = 1 << 39
  39.downto(0) do |digit|
    # 所定のprefixを持つ美しさ数の配列を返す
    found_ary = find_b_nums(prefix, b_ary)
    # puts "#{digit}: #{found_ary}"

    if k <= found_ary.length
      # K個以上見つかったので、見つかった美しさセットを次の検索対象とする
      b_ary = found_ary
      # 1つ下の桁も1にする
      prefix |= (1 << (digit-1))
    else
      # 現在の桁を0にして、次の桁を1にする
      prefix ^= (1 << digit)
      prefix |= (1 << (digit-1))
    end
  end
  puts prefix

end

def find_b_nums(prefix, b_ary)
  found = []
  b_ary.each_with_index do |b, idx|
    if (b & prefix) == prefix
      found << b
    end
  end
  found
end

if __FILE__ == $0
  main
end
