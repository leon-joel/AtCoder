def main
  base, div, target_m = ARGF.gets.split.map(&:to_i)

  1.upto(div) do |n|
    cur = base * n

    m = cur % div
    if m == target_m
      puts "YES"
      return
    end
  end

  puts "NO"
end

if __FILE__ == $0
  main
end
