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

def pop_max_num(nums)
  k, cnt = nums.shift
  return nil if k == 0  # 要素なし の場合はdefault値が返ってくる

  if 2 <= cnt
    nums[k] = cnt-1
  end
  k
end

def find_and_pop_num(nums, n)
  cnt = nums[n]
  return nil if cnt == 0

  if 2 <= cnt
    nums[n] -= 1
  else
    nums.delete(n)
  end
  n
end

def main
  n = gets.chomp.to_i

  nums_ary = gets.split.map(&:to_i)
  nums_ary.sort!
  nums_ary.reverse!
  # puts nums_ary

  nums = nums_ary.each_with_object(Hash.new(0)) do |i, h|
    h[i] += 1
  end
  # puts nums

  ans = 0
  while true
    # 大きい方からxを取り出す
    x = pop_max_num(nums)
    break if x.nil?

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
