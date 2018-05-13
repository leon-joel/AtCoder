n = gets.to_i

layer = n.times.map do
  gets.to_i
end.uniq.size

puts layer
