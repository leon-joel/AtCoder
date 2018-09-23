def gets; ARGF.gets; end

def main
  _, total = gets.split.map(&:to_i)

  children = gets.split.map(&:to_i).sort

  acc = 0
  children.each_with_index do |n, i|
    acc += n

    if total < acc
      # 足りない
      puts i
      return
    end
  end

  if total == acc
    # ぴったり
    puts children.length
  else
    # あまり
    puts children.length - 1
  end
end

if __FILE__ == $0
  main
end
