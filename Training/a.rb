require 'pp'

def gets; ARGF.gets; end

class Solver

  def initialize
  end

  def main
    r = gets.chomp.to_i
    g = gets.chomp.to_i

    puts g + (g - r)
  end
end

if __FILE__ == $0
  Solver.new.main
end
