require 'pp'

def gets; ARGF.gets; end

class Solver

  def initialize
  end

  def main
    n = gets.to_i
    ary = [2, 1]
    (n-1).times do |i|
      ary << ary[-2] + ary[-1]
    end

    puts ary[n]
  end
end

if __FILE__ == $0
  Solver.new.main
end
