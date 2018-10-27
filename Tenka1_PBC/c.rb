require 'pp'

def gets; ARGF.gets; end


def pop_back_gen(nums)
  Fiber.new do
    nums.reverse_each do |i|
      Fiber.yield(i)
    end
  end
end

def pop_front_gen(nums)
  Fiber.new do
    nums.each do |i|
      Fiber.yield(i)
    end
  end
end

def main
  n = gets.chomp.to_i

  nums = Array.new(n)
  n.times do |i|
    nums[i] = gets.chomp.to_i
  end
  # puts nums

  nums.sort!

  # 先頭と末尾から値を取り出すgenerator
  front_gen = pop_front_gen(nums)
  back_gen = pop_back_gen(nums)

  # 中央値からスタート
  last_num = nums[n / 2]

  # 先頭（最小値）から取るパターン
  len_min_first = 0
  0.upto(n-2) do |i|
    cur_num = if i.even?
                # 前を取る
                front_gen.resume
              else
                # 後ろを取る
                back_gen.resume
              end
    len_min_first += (last_num - cur_num).abs
    last_num = cur_num
  end

  front_gen = pop_front_gen(nums)
  back_gen = pop_back_gen(nums)

  # 中央値からスタート
  last_num = nums[n / 2]

  # 末尾（最大値）から取るパターン
  len_max_first = 0
  1.upto(n-1) do |i|
    cur_num = if i.even?
                # 前を取る
                front_gen.resume
              else
                # 後ろを取る
                back_gen.resume
              end
    len_max_first += (last_num - cur_num).abs
    last_num = cur_num
  end

  puts [len_min_first, len_max_first].max
end

if __FILE__ == $0
  main
end
