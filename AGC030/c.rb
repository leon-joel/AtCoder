require 'pp'

def gets; ARGF.gets; end

class Solver
  def main
    n = gets.chomp.to_i
    nums = gets.split.map(&:to_i)


  end
end

if __FILE__ == $0
  Solver.new.main
end
