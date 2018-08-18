def gets; ARGF.gets; end

def main
  a, b = gets.split.map(&:to_i)

  puts (a - 1) * (b - 1)
end

if __FILE__ == $0
  main
end
