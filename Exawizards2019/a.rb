require 'pp'

def gets; ARGF.gets; end

class Solver

  def initialize
  end

  def main
    a, b, c = gets.split.map(&:to_i)

    if a == b && b == c
      puts "Yes"
    else
      puts "No"
    end
  end
end

if __FILE__ == $0
  Solver.new.main
end
