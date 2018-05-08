n = gets.chomp.to_i

cards = gets.split.map(&:to_i).sort.reverse

sums = [0, 0]
n.times do |i|
   sums[i%2] += cards[i]
end

puts sums[0] - sums[1]
