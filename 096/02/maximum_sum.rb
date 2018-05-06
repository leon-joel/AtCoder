nums = gets.split.map(&:to_i)
# puts "#{i1}, #{i2}, #{i3}"
max_num = nums.max
# puts "max_num: #{max_num}"

rest_sum = nums.inject(:+) - max_num
# puts "rest_sum: #{rest_sum}"

k = gets.chomp.to_i
# puts k

sum = max_num * 2 ** k + rest_sum
puts sum
