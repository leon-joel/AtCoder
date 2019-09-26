require 'pp'

def gets; ARGF.gets; end

class Solver

  def initialize
  end

  def main
    n = gets.chomp.to_i
    a = gets.chomp.to_i

    puts n * n - a


  end
end

if __FILE__ == $0
  Solver.new.main
end
