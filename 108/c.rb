def gets; ARGF.gets; end

def mul_num(n, k)
  n / k
end

def main
  n, k = gets.split.map(&:to_i)
  if k.even?
    # kの倍数の個数
    e = mul_num(n, k)

    # 倍数間の真ん中の個数
    o = if k / 2 <= n % k
          e + 1
        else
          e
        end

    # puts e
    # puts o
    puts e**3 + o**3
  else
    e = mul_num(n, k)

    puts e**3
  end
end

if __FILE__ == $0
  main
end
