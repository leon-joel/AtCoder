def main
  a, b, c, d = ARGF.gets.split.map(&:to_i)

  lower = [a, c].max
  upper = [b, d].min

  puts [0, upper - lower].max
end

if __FILE__ == $0
  main
end
