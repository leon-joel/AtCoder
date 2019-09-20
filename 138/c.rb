require 'pp'

def gets; ARGF.gets; end

class Solver

  def main
    n = gets.chomp.to_i
    bs = gets.split.map(&:to_i)

    bs.sort!

    ans = bs.inject(-1) do |ave, i|
      if ave == -1
        i
      else
        (ave + i) / 2.0
      end
    end

    puts ans
  end
end

if __FILE__ == $0
  Solver.new.main
end
