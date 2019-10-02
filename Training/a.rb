require 'pp'

def gets; ARGF.gets; end

class Solver

  def initialize
  end

  def main
    x, t = gets.chomp.split.map(&:to_i)

    ans = x - t
    ans = 0 if ans < 0

    puts ans
  end
end

if __FILE__ == $0
  Solver.new.main
end
