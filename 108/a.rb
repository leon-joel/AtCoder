def gets; ARGF.gets; end

def main
  k = gets.chomp.to_i

  e = k / 2
  o = k - e

  puts e * o
end

if __FILE__ == $0
  main
end
