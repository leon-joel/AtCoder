require 'pp'

def gets; ARGF.gets; end

class Solver
  def main
    a, b, c = gets.split.map(&:to_i)

    ans = 0
    if c <= a + b + 1
      # 毒入り全部OKなので全部OK
      ans = b + c
    else
      # 毒入り食べられる数
      ans = a + b + 1
      # 美味しい解毒剤入り
      ans += b
    end

    puts ans

  end
end

if __FILE__ == $0
  Solver.new.main
end
