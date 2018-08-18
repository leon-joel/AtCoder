def gets; ARGF.gets; end

def main
  total = gets.chomp.to_i

  0.upto(total / 7) do |n7|
    if (total - 7 * n7) % 4 == 0
      puts 'Yes'
      return
    end
  end
  puts 'No'
end

if __FILE__ == $0
  main
end
