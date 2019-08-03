require 'pp'

def gets; ARGF.gets; end

class Solver

  def initialize
    @nums = []
  end

  def main
    n, m = gets.split.map(&:to_i)
    ary = Array.new(n)
    n.times do |i|
      ary[i] = gets.split.map(&:to_i)
    end
    ary.sort!
    # puts ary

    ans = 0
    ary.each do |k, v|
      if m <= v
        # 足りる
        ans += k * m
        break
      else
        # 足りない
        ans += k * v
        m -= v
      end
    end

    puts ans
  end
end

if __FILE__ == $0
  Solver.new.main
end
