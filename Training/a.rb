require 'pp'

def gets; ARGF.gets; end

class Solver

  def initialize
  end

  def main
    n = gets.chomp.to_i

    ans = 1
    loop do
      v = ans * 2
      break if n < v

      ans = v
    end

    puts ans
  end
end

if __FILE__ == $0
  Solver.new.main
end
