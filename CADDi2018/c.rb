require 'pp'

def gets; ARGF.gets; end

require 'prime'

class Solver
  def main
    n, p = gets.split.map(&:to_i)

    pds = Prime.prime_division(p)  #=> [[5, 1], [197, 1], [461, 1]]

    ans = 1
    pds.each do |(base, exp)|
      e = exp / n
      ans *= base**e
    end

    puts ans
  end
end

if __FILE__ == $0
  Solver.new.main
end
