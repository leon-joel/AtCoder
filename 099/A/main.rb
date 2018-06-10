def main
  n = ARGF.gets.chomp.to_i

  if n < 1000
    puts "ABC"
  else
    puts "ABD"
  end
end

if __FILE__ == $0
  main
end
