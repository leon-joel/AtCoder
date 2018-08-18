def gets; ARGF.gets; end

def main
  n, k = gets.split.map(&:to_i)

  if n % k == 0
    puts 0
  else
    puts 1
  end
end

if __FILE__ == $0
  main
end
