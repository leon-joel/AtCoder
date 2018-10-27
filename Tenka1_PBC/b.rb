require 'pp'

def gets; ARGF.gets; end

def main
  p0, p1, op_num = gets.split.map(&:to_i)

  op_num.times do |i|
    if i.even?
      # p0 のターン
      p0 -= 1 if p0.odd?
      half = p0 / 2
      p0 -= half
      p1 += half
    else
      # p1 のターン
      p1 -= 1 if p1.odd?
      half = p1 / 2
      p1 -= half
      p0 += half
    end
  end

  puts "#{p0} #{p1}"
end

if __FILE__ == $0
  main
end
