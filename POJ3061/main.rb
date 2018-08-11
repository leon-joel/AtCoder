require 'pp'

def main
  q_num = ARGF.gets.to_i

  q_num.times do
    nums_len, target = ARGF.gets.split.map(&:to_i)
    nums = ARGF.gets.split.map(&:to_i)

    # 最短区間長
    min_len = nums_len + 1

    # 左端からスタート
    r = 0
    sum = 0
    0.upto(nums.length-1) do |l|
      # [left, right) の総和が target 以上となる最小の right を求める
      # ※右端は開区間である（rightを含まない）ことに留意
      while r < nums.length && sum < target
        sum += nums[r]
        r += 1
      end

      # これ以上left を進めても無駄
      break if sum < target

      # 最小を更新
      min_len = [min_len, r - l].min

      # leftを動かす準備
      if r == l
        # r と l が同じ位置の場合、rを動かす必要がある。
        # そして、sumはすでに0のはずなので減算しない
        r += 1
      else
        # leftが右に動くので減算しておく
        sum -= nums[l]
      end
    end

    # この問題の場合「解無し」チェックが必要
    if min_len < nums_len + 1
      puts min_len
    else
      puts 0
    end
  end
end

if __FILE__ == $0
  main
end
