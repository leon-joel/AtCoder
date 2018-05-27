def main
  n = ARGF.gets.to_i

  nums = ARGF.gets.split.map(&:to_i)

  cnt = n
  exor = 0
  suc_j = 0
  0.upto(n-2) do |i|
    if i+1 <= suc_j
      cnt += suc_j - i
      exor ^= nums[i-1]
    else
      suc_j = i
      exor = nums[i]
    end
    (suc_j+1).upto(n-1) do |j|
      mul = exor & nums[j]
      break if mul != 0

      exor ^= nums[j]   # or でも結果は同じはず
      cnt += 1
      suc_j = j
    end

  end
  puts cnt
end

if __FILE__ == $0
  main
end
