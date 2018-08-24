require 'pp'

def gets; ARGF.gets; end

def main
  n, k = gets.split.map(&:to_i)

  nums = Array.new(n)
  n.times do |i|
    # 0 が含まれているときは配列長をそのまま返す
    nums[i] = gets.chomp.to_i
    if nums[i] == 0
      puts n
      return
    end
  end
  # pp nums

  ans = 0

  # 左端からスタート
  r = 0
  mul = 1
  0.upto(nums.length-1) do |l|
    # [left, right) 内の数字の積が k 以下となる最大の r-l を求める
    while r < nums.length && mul * nums[r] <= k
      mul *= nums[r]
      r += 1
    end

    # この時点で r は(条件を満たす最大のidx)+1となっている。
    # ※r側を開区間と考えると、rは（条件を満たす最大のidx）になっている。
    ans = r - l if ans < r - l

    # leftを動かす準備
    if r == l
      # r と l が同じ位置の場合、rを動かす必要がある。
      # そして、mulはすでに1のはずなのでそのまま
      r += 1
    else
      # leftが右に動くので除算しておく
      mul /= nums[l]
    end
  end

  puts ans
end

if __FILE__ == $0
  main
end
