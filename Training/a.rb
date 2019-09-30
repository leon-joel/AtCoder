require 'pp'

def gets; ARGF.gets; end

class Solver

  def initialize
  end

  def main
    s = gets.chomp

    ans = ""

    s.each_char.with_index do |c, i|
      ans += c if (i+1).odd?
    end

    puts ans
  end
end

if __FILE__ == $0
  Solver.new.main
end
