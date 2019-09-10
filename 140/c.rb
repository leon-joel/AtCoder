require 'pp'

def gets; ARGF.gets; end

class Solver

  def main
    n = gets.chomp.to_i
    bs = gets.split.map(&:to_i)

    as = Array.new(n) {1000000}
    # puts as

    bs.each.with_index do |b, i|
      as[i] = [as[i], bs[i]].min
      as[i+1] = [as[i+1], bs[i]].min
    end



    puts as.inject(:+)
  end
end

if __FILE__ == $0
  Solver.new.main
end
