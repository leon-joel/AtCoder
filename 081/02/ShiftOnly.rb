_ = gets.chomp.to_i

nums = gets.split.map(&:to_i)

min_div = 32  # Aの範囲が 10^9 までなので最大でも32回？しか2で割れない
nums.each do |num|
  cur_div = 0
  # []演算子で指定bit位置の値が取れる ※[0]が最下位（1の位）
  # 実際にbitシフトしていくよりも（この部分だけにおいては）数倍高速とのこと https://qiita.com/jkr_2255/items/8e29dce1999f3f6b69ad
  while (num[cur_div] & 1) == 0
    cur_div += 1
  end
  # puts "cur_div: #{cur_div}"

  if cur_div < min_div
    min_div = cur_div
  end
end

puts min_div
