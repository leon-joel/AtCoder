def main
  _ = ARGF.gets.to_i

  a1 = ARGF.gets.split.map(&:to_i)
  a2 = ARGF.gets.split.map(&:to_i)

  # 累積和を求める
  sum = 0
  sum_a1 = a1.map do |num|
    sum += num
    sum
  end
  # puts sum_a1

  max_sum = 0
  sum = 0
  a2.each_with_index.reverse_each do |num, i|
    # 後ろから、かつidxも大きい方から
    sum += num
    sum2 = sum + sum_a1[i]
    if max_sum < sum2
      max_sum = sum2
    end
  end

  puts max_sum
end

if __FILE__ == $0
  main
end
