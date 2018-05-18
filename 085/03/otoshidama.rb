num, sum = gets.split.map(&:to_i)

max10k = [sum / 10000, num].min
0.upto max10k do |n10k|
  rest_sum = sum - n10k * 10000

  max_5k = [rest_sum / 5000, num - n10k].min
  0.upto max_5k do |n5k|
    rest_sum_inner = rest_sum - n5k * 5000

    n1k = num - n10k - n5k
    if rest_sum_inner / 1000 == n1k
      # 見つかった！
      puts "#{n10k} #{n5k} #{n1k}"
      exit(0)
    end
  end
end

# 見つからなかった
puts "-1 -1 -1"
