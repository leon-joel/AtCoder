require 'pp'

def gets; ARGF.gets; end

class Solver

  def main
    n = gets.chomp.to_i
    ary = gets.split.map(&:to_i)

    streak = -1
    max_streak = 0
    pre_h = 1000000001
    n.times do |i|
      if ary[i] <= pre_h
        streak += 1
        max_streak = streak if max_streak < streak
      else
        streak = 0
      end
      pre_h = ary[i]
    end

    puts max_streak
  end
end

if __FILE__ == $0
  Solver.new.main
end
