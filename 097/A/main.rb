def main
  a, b, c, dist = ARGF.gets.split.map(&:to_i)

  if (a-c).abs <= dist || ((a-b).abs <= dist && (b-c).abs <= dist)
    puts 'Yes'
  else
    puts 'No'
  end
end

if __FILE__ == $0
  main
end
