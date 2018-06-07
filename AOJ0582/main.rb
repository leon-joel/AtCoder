def main
  over90_num = eq90_num = less90_num = 0
  while s = ARGF.gets&.split&.map(&:to_i)&.sort

    # 三角形？
    # 短辺 + 短辺 <= 最長辺 なら三角形にならない
    break if s[0] + s[1] <= s[2]

    d = s[0]**2 + s[1]**2 - s[2]**2
    if d == 0
      eq90_num += 1
    elsif 0 < d
      # 鋭角
      less90_num += 1
    else
      # 鈍角
      over90_num += 1
    end
  end

  puts "#{over90_num + eq90_num + less90_num} #{eq90_num} #{less90_num} #{over90_num}"
end

if __FILE__ == $0
  main
end
