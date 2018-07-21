def rotate(src)
  src[-1] + src[0..-2]
end

def main
  s = ARGF.gets.chomp
  t = ARGF.gets.chomp

  if s == t
    puts 'Yes'
    return
  end

  (s.length - 1).times do
    # 回転
    r = rotate(s)
    if r == t
      puts 'Yes'
      return
    end

    s = r
  end

  puts 'No'
end

if __FILE__ == $0
  main
end
