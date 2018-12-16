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

def main
  n = gets.chomp.to_i

  nums = gets.split.map(&:to_i)
  nums.sort!
  nums.reverse!
  # puts nums

  ans = 0
  while 1 < nums.length
    # 大きい方からxを取り出す（remove）
    x = nums.delete_at(0)

    # x に対する相方yを探す
    #   x < x + y <= 2x
    # を満たす2べきは1つしかない
    b = beki(x)
    y = b - x

    y_idx = nums.find_index(y)
    if y_idx
      # 相方yがnumsに見つかったら y もremove
      nums.delete_at(y_idx)
      ans += 1
    end
  end
  puts ans
end

if __FILE__ == $0
  main
end
