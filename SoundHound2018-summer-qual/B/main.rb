def main
  chars = ARGF.gets.chomp.chars
  n = ARGF.gets.to_i

  i = 0

  while i < chars.length
    print chars[i]
    i += n
  end
  puts
end

if __FILE__ == $0
  main
end
