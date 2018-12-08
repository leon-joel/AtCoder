require 'pp'

def gets; ARGF.gets; end

def main
  n = gets.chomp.to_i

  total_price = 0
  items = []
  n.times do
    price = gets.chomp.to_i
    items << price
    total_price += price
  end

  items.sort!

  discount = items[-1] / 2

  puts total_price - discount
end

if __FILE__ == $0
  main
end
