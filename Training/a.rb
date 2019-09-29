require 'pp'

def gets; ARGF.gets; end

class XY
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end
  def to_s
    "(#{@x},#{@y})"
  end
  def ==(other)
    @x == other.x && @y == other.y
  end
  def eql?(other)
    self.==(other)
  end
  def +(other)
    XY.new(@x + other.x, @y + other.y)
  end
end

class Solver

  def initialize
  end

  def main
    n, m = gets.chomp.split.map(&:to_i)

    ns = gets.chomp.split.map(&:to_i)
    ms = gets.chomp.split.map(&:to_i)

    ary = Array.new(2 * 1000000)
    ns.each_with_index do |a, ia|
      ms.each_with_index do |b, ib|
        w = a + b
        if ary[w].nil?
          ary[w] = XY.new(ia, ib)
        else
          r = ary[w]
          puts "#{r.x} #{r.y} #{ia} #{ib}"
          return
        end
      end
    end

    puts "-1"
  end
end

if __FILE__ == $0
  Solver.new.main
end
