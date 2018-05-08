_ = gets.chomp.to_i

cards = gets.split.map(&:to_i)
cards.sort!

sum_a = 0
sum_b = 0
cards.reverse.each_slice(2) do |(a, b)|
  sum_a += a
  sum_b += (b || 0)
end
puts sum_a - sum_b
