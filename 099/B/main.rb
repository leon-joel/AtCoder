def main
  a, b = ARGF.gets.split.map(&:to_i)

  m = b - a - 1

  s = (1 + m) * (m / 2.0)
  snow = s - a

  puts snow.to_i
end

if __FILE__ == $0
  main
end
