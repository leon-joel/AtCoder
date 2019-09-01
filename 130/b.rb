require 'pp'

def gets; ARGF.gets; end

class Solver

  def initialize
  end

  def main
    h, w, q = gets.split.map(&:to_i)

    g = []
    h.times do |r|
      g << "." * w
    end
    # puts g

    q.times do |i|
      r, c, s = gets.split
      g[r.to_i - 1][c.to_i - 1] = s
    end
    puts g
  end
end

if __FILE__ == $0
  Solver.new.main
end
