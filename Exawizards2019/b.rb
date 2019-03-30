require 'pp'

def gets; ARGF.gets; end

class Solver

  def initialize
  end

  def main
    n = gets.chomp.to_i
    s = gets.chomp

    r_cnt = 0
    b_cnt = 0
    s.each_char do |c|
      if c == 'R'
        r_cnt += 1
      else
        b_cnt += 1
      end
    end

    if b_cnt < r_cnt
      puts "Yes"
    else
      puts "No"
    end
  end
end

if __FILE__ == $0
  Solver.new.main
end
