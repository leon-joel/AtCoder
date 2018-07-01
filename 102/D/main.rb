def main
  n = ARGF.gets.chomp.to_i
  nums = ARGF.gets.split.map(&:to_i)

  sum = nums.inject(&:+)

  min_diff = 10**9
  1.upto(nums.length - 3) do |c1|
    r1_sum = nums.slice(0, c1).inject(&:+)

    1.upto(nums.length - 2 - c1) do |c2|
      r2_sum = nums.slice(c1, c2).inject(&:+)

      1.upto(nums.length - 1 - c1 - c2) do |c3|
        r3_sum = nums.slice(c1+c2, c3).inject(&:+)

        r4_sum = sum - (r1_sum + r2_sum + r3_sum)

        min, max = [r1_sum, r2_sum, r3_sum, r4_sum].minmax
        d = max - min

        if d < min_diff
          min_diff = d
        end
      end
    end
  end

  puts min_diff
end

if __FILE__ == $0
  main
end
