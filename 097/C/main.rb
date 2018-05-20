def main
  n = ARGF.gets.to_i
  # puts("Error") if n <= 0

  n.times do
    t, x, y = ARGF.gets.split.map(&:to_i)


  end

  puts 'Yes'
end

if __FILE__ == $0
  main
end
