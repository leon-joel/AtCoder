def main
  a, b = ARGF.gets.split.map(&:to_i)

  if a * b == 15
    puts "*"
  elsif a + b == 15
    puts "+"
  else
    puts "x"
  end
end

if __FILE__ == $0
  main
end
