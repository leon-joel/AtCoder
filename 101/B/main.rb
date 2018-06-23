def main
  n = ARGF.gets.to_i
  s = n.to_s.chars.map(&:to_i).inject(&:+)

  if n % s == 0
    puts 'Yes'
  else
    puts 'No'
  end
end

if __FILE__ == $0
  main
end
