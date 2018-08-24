require 'pp'

def gets; ARGF.gets; end

def main
  n = gets.chomp.to_i

  nums = gets.split.map(&:to_i)
  # pp nums

  ans = 0

  # 左端からスタート
  l = 0
  r = 0
  last = 0
  while l < nums.length
    # [left, right) 内の数字が単調増加であるなら r を進める
    while r < nums.length && last < nums[r]
      last = nums[r]
      r += 1
    end

    # r側を開区間と考えると、rは（条件を満たす最大のidx）になっている。
    d = r - l
    ans += (d * (d + 1)) / 2

    # l を r まで進める
    l = r
    last = 0
  end

  puts ans
end

if __FILE__ == $0
  main
end
