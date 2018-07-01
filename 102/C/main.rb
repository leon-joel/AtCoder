def calc_diff_sum(nums, n)
  nums.inject(0) do |s, i|
    s += (i - n).abs
  end
end

def main

  n = ARGF.gets.chomp.to_i
  nums = ARGF.gets.split.map.with_index do |s, idx|
    s.to_i - idx
  end
  # puts nums

  ave = (nums.inject(:+).to_f / nums.length).round

  min_diff_sum = calc_diff_sum(nums, ave)

  # 下向き
  lower_limit = (10**5*2) * -1
  (ave-1).downto(lower_limit) do |c|
    ds = calc_diff_sum(nums, c)

    break if min_diff_sum < ds

    min_diff_sum = ds
  end

  upper_limit = 10**5*2
  (ave+1).upto(upper_limit) do |c|
    ds = calc_diff_sum(nums, c)

    break if min_diff_sum < ds

    min_diff_sum = ds
  end

  puts min_diff_sum

  # 6 5 4 3 2 1
  # 6 4 2 0 -2 -4
  # ave: 1
  # diff
  # 5 3 1 1 3 5
  # sum: 18

  # 1 1 1 1 2 3 4
  # 1 0 -1 -2 -2 -2 -2
  # ave: -8/7 => -1
  # diff
  # 2 1 0 1 1 1 1
  # sum: 7
  # AVE: -2
  # diff
  # 3 2 1 0 0 0 0
  # sum: 6
  #
  # 1 1 1 1 2 3 4
  # 7 6 5 4 4 4 4
  # sum 34 ave 34/7 = 4.888

end

if __FILE__ == $0
  main
end
