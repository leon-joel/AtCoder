require 'pp'

def gets; ARGF.gets; end

class Solver

  def initialize
  end

  def main
    n, x = gets.split.map(&:to_i)
    ls = gets.split.map(&:to_i)

    cnt = 1
    sum = 0
    ls.each do |l|
      sum += l
      if x < sum
        break
      else
        cnt += 1
      end
    end

    puts cnt
  end
end

if __FILE__ == $0
  Solver.new.main
end
