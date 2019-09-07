require 'pp'

def gets; ARGF.gets; end

class Solver

  def initialize
  end

  def main
    a, b = gets.split.map(&:to_i)

    ans = 0
    if b == 1
      ans = 0
    else
      b -= 1
      ans = (b + (a - 1 - 1)) / (a - 1)
    end

    puts ans
  end
end

if __FILE__ == $0
  Solver.new.main
end
