require 'pp'

def main
  nums_len, q_len = ARGF.gets.split.map(&:to_i)

  nums = ARGF.gets.split.map(&:to_i)
  q_nums = ARGF.gets.split.map(&:to_i)

  q_nums.each do |q|
    ans = 0

    # 左端からスタート
    0.upto(nums.length-1) do |l|
      # [left, right) の総和が q 以下となる最大の right を求める
      r = l
      sum = 0
      while r < nums.length && sum + nums[r] <= q
        sum += nums[r]
        r += 1
      end

      # この時点で r は(条件を満たす最大のidx)+1となっているので、
      # (r - l) が可能な組み合わせ数
      ans += r - l
    end

    puts ans
  end
end

if __FILE__ == $0
  main
end
