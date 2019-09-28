require 'pp'

def gets; ARGF.gets; end

class Solver

  def initialize
  end

  def main
    s = gets.chomp

    if s[0] == '9' || s[1] == '9'
      puts "Yes"
    else
      puts "No"
    end

  end
end

if __FILE__ == $0
  Solver.new.main
end
