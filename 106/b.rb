def gets; ARGF.gets; end

def main
  n = gets.chomp.to_i

  ans = 0
  1.upto(n) do |i|
    next if i.even?
    cnt = 0
    1.upto(i) do |d|
      if i % d == 0
        cnt += 1
      end
    end
    ans += 1 if cnt == 8
  end
  puts ans
end

if __FILE__ == $0
  main
end
