require 'pp'

def gets; ARGF.gets; end

class Solver
  def main
    a, b = gets.split.map(&:to_i)
    # puts a, b

    # 2進数で1の桁から順に論理和を計算していく
    # 10^12 = 2^40

    ans = 0
    0.upto(40) do |i|
      # i桁目について:
      # A-1 までに1がいくつ立っているか->偶数？奇数？がわかれば良い
      isEvenA = isEvenBits(a-1, i)
      isEvenB = isEvenBits(b, i)

      if isEvenA != isEvenB
        ans += (1 << i)
      end
    end
    puts ans
  end

  # i桁目について、n以下の整数でいくつbitが立っているか？
  # というか偶数か奇数か？
  def isEvenBits(n, i)
    if n <= 0
      true
    elsif i == 0
      r = n % 4
      (r == 0 || r == 3)
    elsif n[i] == 0
      true
    else
      n.odd?
    end
  end
end

if __FILE__ == $0
  Solver.new.main
end
