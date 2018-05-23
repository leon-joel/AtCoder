def main
  n = ARGF.gets.to_i

  d = 1_000_000_007

  current = 1
  1.upto n do |n|
    current *= n

    if d <= current
      current %= d
    end
  end

  puts current
end

if __FILE__ == $0
  main
end
