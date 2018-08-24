require 'pp'

def gets; ARGF.gets; end

# しゃくとり法
# https://qiita.com/drken/items/ecd1a472d3a0e7db8dce
# http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DSL_3_C&lang=jp

def main
  nums_len, q_len = gets.split.map(&:to_i)

  nums = gets.split.map(&:to_i)
  q_nums = gets.split.map(&:to_i)

  q_nums.each do |q|
    ans = 0

    # 左端からスタート
    r = 0
    sum = 0
    0.upto(nums.length-1) do |l|
      # [left, right) の総和が q 以下となる最大の right を求める
      while r < nums.length && sum + nums[r] <= q
        sum += nums[r]
        r += 1
      end

      # この時点で r は(条件を満たす最大のidx)+1となっている。
      # ※r側を開区間と考えると、rは（条件を満たす最大のidx）になっている。
      # (r - l) が可能な組み合わせ数
      ans += r - l

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

    puts ans
  end
end

if __FILE__ == $0
  main
end
