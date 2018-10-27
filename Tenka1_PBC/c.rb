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

  # 先頭（最小値）から取るパターン
  len_min_first = 0
  # めんどくさいから最初の1つだけ取っておく
  last_num = front_gen.resume
  1.upto(n-1) do |i|
    cur_num = if i.even?
                # 前を取る
                front_gen.resume
              else
                # 後ろを取る
                back_gen.resume
              end
    len_min_first += (last_num - cur_num).abs
  end

  # 末尾（最大値）から取るパターン
  len_max_first = 0
  # めんどくさいから最初の1つだけ取っておく
  front_gen = pop_front_gen(nums)
  back_gen = pop_back_gen(nums)
  last_num = back_gen.resume
  1.upto(n-1) do |i|
    cur_num = if i.odd?
                # 前を取る
                front_gen.resume
              else
                # 後ろを取る
                back_gen.resume
              end
    len_max_first += (last_num - cur_num).abs
  end

  puts [len_min_first, len_max_first].max
end


if __FILE__ == $0
  main
end
