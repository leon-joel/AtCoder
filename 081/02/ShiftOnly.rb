_ = gets.chomp.to_i

nums = gets.split.map(&:to_i)

min_div = 32  # Aの範囲が 10^9 までなので最大でも32回？しか2で割れない
nums.each do |num|
  cur_div = 0
  while (num & 1) == 0
    cur_div += 1
    num >>= 1
  end
  # puts "cur_div: #{cur_div}"

  if cur_div < min_div
    min_div = cur_div
  end
end

puts min_div
