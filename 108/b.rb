require 'pp'

def gets; ARGF.gets; end

def rot90(v)
  [-v[1], v[0]]
end

def main
  x1, y1, x2, y2 = gets.split.map(&:to_i)

  v12 = [x2 - x1, y2 - y1]
  # pp v12

  # 時計回りに90°回転
  v23 = rot90(v12)
  x3, y3 = [x2 + v23[0], y2 + v23[1]]

  v34 = rot90(v23)
  x4, y4 = [x3 + v34[0], y3 + v34[1]]

  puts "#{x3} #{y3} #{x4} #{y4}"
end

if __FILE__ == $0
  main
end
