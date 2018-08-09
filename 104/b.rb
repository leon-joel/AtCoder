def main
  s = ARGF.gets.chomp

  if s =~ /^A[a-z][a-z]*C[a-z]*[a-z]$/
    puts "AC"
  else
    puts "WA"
  end
end

if __FILE__ == $0
  main
end
