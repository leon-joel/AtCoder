require 'pp'

def gets; ARGF.gets; end

def beki(n)
  # n より大きい、最小の2べき数を見つける
  # 1 -> 2     0001 ->  0010
  # 2 -> 4     0010 ->  0100
  # 3 -> 4     0011
  # 4 -> 8     0100 ->  1000
  # 5 -> 8     0101
  # 6 -> 8     0110
  # 7 -> 8     0111
  # 8 -> 16    1000 -> 10000
  # 15 -> 16   1111 -> 10000
  # 16 -> 32  10000 ->100000

  # 最上位ビットの位置
  pos = n.bit_length

  1 << pos
end

def pop_max_num(nums, max_num)
  max_num.downto(1) do |i|
    cnt = nums.fetch(i, nil)
    next if cnt.nil? || cnt == 0

    nums[i] -= 1
    return i
  end
  nil
end

def find_and_pop_num(nums, n)
  return nil if nums[n] == 0

  if 1 <= nums[n]
    nums[n] -= 1
  end
  n
end

def main
  n = gets.chomp.to_i

  max_num = 0
  nums = gets.split.each_with_object(Hash.new(0)) do |c, h|
    i = c.to_i
    max_num = i if max_num < i
    h[i] += 1
  end
  # puts nums
  # puts max_num

  ans = 0
  while true
    # 大きい方からxを取り出す
    max_num = x = pop_max_num(nums, max_num)
    break if max_num.nil?

    # x に対する相方yを探す
    # y <= x なので、
    #   x < x + y <= 2x
    # を満たす2べきは1つしかない
    b = beki(x)
    y = b - x

    # 相方 y を取り出す
    y = find_and_pop_num(nums, y)
    if y
      # 見つかった！
      ans += 1
    end
  end
  puts ans
end

if __FILE__ == $0
  main
end
