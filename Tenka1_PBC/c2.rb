require 'pp'

def gets; ARGF.gets; end

# 解説放送通りの解法
# 速い ＆ 数学的に間違いない（漏れがない）
# という点で自分回答よりこちらのほうがベター。
def main
  n = gets.chomp.to_i
  nums = Array.new(n)
  n.times do |i|
    nums[i] = gets.chomp.to_i
  end

  # ※ホントはreverse不要。あとのif条件を変えればいいだけなので。
  nums.sort!.reverse!

  ans = 0
  if n.even?
    # 偶数個(6個)の場合: +2, +2, +1, -1, -2, -2
    #       (4個)      :     +2, +1, -1, -2
    #       (2個)      :         +1, -1
    #                                ↑center_idx
    center_idx = n / 2
    nums.each_with_index do |num, idx|
      if idx < center_idx - 1
        ans += num * 2
      elsif center_idx < idx
        ans -= num * 2
      elsif idx == center_idx
        ans -= num
      else
        ans += num
      end
    end
  else
    # 奇数個(5個)の場合: +2, +2, -1, -1, -2
    #                    +2, +1, +1, -2, -2
    #       (3個)      :     +2, -1, -1
    #                        +1, +1, -2
    #                            ↑center_idx
    center_idx = n / 2

    # +2, -1, -1 パターン
    ans0 = 0
    nums.each_with_index do |num, idx|
      if idx < center_idx
        ans0 += num * 2
      elsif center_idx + 1 < idx
        ans0 -= num * 2
      else
        ans0 -= num
      end
    end

    # +1, +1, -2 パターン
    ans1 = 0
    nums.each_with_index do |num, idx|
      if idx < center_idx - 1
        ans1 += num * 2
      elsif center_idx < idx
        ans1 -= num * 2
      else
        ans1 += num
      end
    end

    ans = [ans0, ans1].max
  end

  puts ans
end

if __FILE__ == $0
  main
end
