require 'pp'

def gets; ARGF.gets; end

def main
  n, m = gets.split.map(&:to_i)
  # 割り切れるなら➾即決
  if m % n == 0
    puts m / n
    return
  end

  (m/n).downto(2) do |d|
    next if m % d != 0

    # 割り切れるのでチャンスはあるが、
    # 個数の問題をクリアできるか？
    num = m / d
    if n <= num
      puts d
      return
    end
  end
  puts 1
end

if __FILE__ == $0
  main
end
