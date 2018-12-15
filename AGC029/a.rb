require 'pp'

def gets; ARGF.gets; end

def main
  s_ary = gets.chomp.chars
  # puts s

  # 左から
  # Bの数を数えながら
  # Wが出たら、そこまでのBの数だけ ans に加算
  b_num = 0
  ans = 0
  s_ary.each do |c|
    if c == "B"
      b_num += 1
    else
      ans += b_num
    end
  end

  puts ans
end

if __FILE__ == $0
  main
end
