def main
  num = ARGF.gets.chomp.to_i
  if num <= 0
    puts 'Yes'
    return
  end

  changes = ARGF.gets.each_char do |c|
    if c == '+'
      num += 1
    else
      num -= 1
      if num <= 0
        puts 'Yes'
        return
      end
    end
  end

  puts 'No'
end

if __FILE__ == $0
  main
end
