def main
  s = ARGF.gets.chomp

  if /^MUJIN.*/ =~ s
    puts 'Yes'
  else
    puts 'No'
  end
end

if __FILE__ == $0
  main
end
