require 'pp'

def gets; ARGF.gets; end

class Solver

  def initialize
  end

  def main
    n, m = gets.chomp.split.map(&:to_i)

    puts "#{(n - 1) * (m - 1)}"
  end
end

if __FILE__ == $0
  Solver.new.main
end
