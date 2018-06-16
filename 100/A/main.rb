def main
  a, b = ARGF.gets.split.map(&:to_i)

  if a <= 8 && b <= 8
    puts "Yay!"
  else
    puts ":("
  end
end

if __FILE__ == $0
  main
end
