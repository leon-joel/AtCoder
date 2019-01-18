require 'pp'

def gets; ARGF.gets; end

def main
  a, b, c, x, y = gets.split.map(&:to_i)

  max_xy = [x, y].max
  # puts max_xy

  min_price = 1 << 30
  0.step(max_xy * 2, 2) do |ab_num|
    price = ab_num * c

    if ab_num / 2 < x
      price += (x - ab_num / 2) * a
    end
    if ab_num / 2 < y
      price += (y - ab_num / 2) * b
    end

    min_price = price if price < min_price
  end

  puts min_price


end

if __FILE__ == $0
  main
end
