require 'pp'

def gets; ARGF.gets; end

class Solver

  def main
    n = gets.chomp.to_i

    n -= 1

    ans = (1 + n) * n / 2

    puts ans
  end
end

if __FILE__ == $0
  Solver.new.main
end
