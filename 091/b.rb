require 'pp'

def gets; ARGF.gets; end

class Solver

  def initialize
  end

  def main
    n = gets.chomp.to_i

    h = Hash.new(0)
    n.times do |i|
      h[gets.chomp] += 1
    end

    m = gets.chomp.to_i
    m.times do |i|
      h[gets.chomp] -= 1
    end

    max_v = -200
    h.each do |k, v|
      if max_v < v
        max_v = v
      end
    end

    if max_v < 0
      puts 0
    else
      puts max_v
    end

  end
end

if __FILE__ == $0
  Solver.new.main
end
