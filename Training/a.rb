require 'pp'

def gets; ARGF.gets; end

class Solver

  def initialize
  end

  def main
    n = gets.chomp.to_i
    k = gets.chomp.to_i

    xs = gets.chomp.split.map(&:to_i)

    ans = 0
    xs.each do |x|
      ans += [x, (x - k).abs].min * 2
    end

    puts ans

  end
end

if __FILE__ == $0
  Solver.new.main
end
