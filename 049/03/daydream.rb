s = gets.chomp
# puts s

if s =~ /^(dream|dreamer|erase|eraser)+$/
  puts 'YES'
else
  puts 'NO'
end
