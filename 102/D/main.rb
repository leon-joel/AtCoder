def main
  knum = ARGF.gets.chomp.to_i

  1.upto(knum) do |k|
    # 累乗数 0, 1, 2, ...
    n = (k-1) / 9

    # ベース数 1, 10, 100, ...
    b = 10**n

    # 剰余数 1, 2, ..., 9, 1, 2, 3, ...
    r = (k-1) % 9 + 1

    # すぬけ数
    s = b * (r + 1) - 1

    puts s
  end
end

if __FILE__ == $0
  main
end
