def main
  _ = ARGF.gets
  nums = ARGF.gets.split.map(&:to_i)

  magic_cnt = 0
  last = -1
  nums.each do |n|
    if last == -1
      last = n
    elsif last == n
      magic_cnt += 1
      last = -1
    else
      last = n
    end
  end
  puts magic_cnt
end

if __FILE__ == $0
  main
end
