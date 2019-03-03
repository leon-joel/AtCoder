require 'pp'

def gets; ARGF.gets; end

require 'prime'

class Solver

  def initialize
    @nums = []
  end

  def main
    a, b, k = gets.split.map(&:to_i)
    # puts a, b, k

    m = a.gcd(b)
    # puts m

    pd = Prime.prime_division(m)  #=> [[5, 1], [197, 1], [461, 1]]
    # puts pd

    dnum(pd, 0, 1)

    @nums.uniq!
    @nums.sort!
    @nums.reverse!

    puts @nums[k-1]
  end

  # 約数
  def dnum(pdnum, idx, acc)
    if pdnum.length == idx
      @nums << acc
      return
    end

    k, v = pdnum[idx]
    0.upto(v) do |n|
      dnum(pdnum, idx + 1, acc * (k ** n))
    end
  end
end

if __FILE__ == $0
  Solver.new.main
end
