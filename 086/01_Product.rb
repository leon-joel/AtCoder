n1, n2 = gets.split.map(&:to_i)
# puts "#{n1}, #{n2}"

if n1.even? || n2.even?
  puts "Even"
else
  puts "Odd"
end
