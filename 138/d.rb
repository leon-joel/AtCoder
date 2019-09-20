require 'pp'

def gets; ARGF.gets; end

class Solver

  def main
    n, k = gets.chomp.split.map(&:to_i)

    last_c = 'Z'
    num = 0
    nums = []
    gets.chomp.each_char do |c|
      if last_c != c
        nums << num
        num = 1
      else
        num += 1
      end
      last_c = c
    end
    nums << num
    nums << 0
    # puts nums

    # 持ち点計算
    sum = 0
    nums.each do |i|
      if 1 < i
        sum += i - 1
      end
    end
    # puts sum

    # (n * 2) + 1 長さ の合計を尺取で
    # そのとき、2以上のを取り込んだら、rest を引いていく
    # 2以上のを排出したら rest に加算しておく
    rest = sum

    l = 0
    r = [k * 2, nums.length - 1].min
    cur = 0
    max_p = 0
    l.upto(r) do |i|
      if 1 < nums[i]
        rest -= nums[i] - 1
      end
      cur += nums[i]
    end
    if max_p < (cur - 1) + rest
      max_p = (cur - 1) + rest
    end

    t = nums.length - (k * 2 + 1)
    if t <= 0
      puts max_p
      return
    end

    t.times do
      if 1 < nums[l]
        rest += nums[l] - 1
      end
      cur -= nums[l]
      l += 1

      r += 1
      if 1 < nums[r]
        rest -= nums[r] - 1
      end
      cur += nums[r]

      if max_p < (cur - 1) + rest
        max_p = (cur - 1) + rest
      end
    end

    puts max_p
  end
end

if __FILE__ == $0
  Solver.new.main
end
