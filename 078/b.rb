require 'pp'

def gets; ARGF.gets; end

class Solver

  def initialize
  end

  def main
    x, y, z = gets.split.map(&:to_i)

    ans = (x - z) / (y + z)
    puts ans
  end
end

if __FILE__ == $0
  Solver.new.main
end
