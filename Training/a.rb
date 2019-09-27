require 'pp'

def gets; ARGF.gets; end

class Solver

  def initialize
  end

  def main
    n = gets.chomp.to_i

    ans = 0
    n.times do
      l, r = gets.chomp.split.map(&:to_i)
      ans += (r - l) + 1
    end

    puts ans
  end
end

if __FILE__ == $0
  Solver.new.main
end
