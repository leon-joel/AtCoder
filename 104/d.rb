require 'pp'

DIV_NUM = 10**9+7

def main
  s = ARGF.gets.chomp.reverse

  c_ary = Array.new(s.length, 0)
  b_ary = Array.new(s.length, 0)
  a_ary = Array.new(s.length, 0)

  q_num = 0
  0.upto(s.length) do |i|
    case s[i]
    when 'A','B'
      c_ary[i] = c_ary[i-1]
    when 'C'
      c_ary[i] = (c_ary[i-1] + 3**q_num) % DIV_NUM
    when '?'
      c_ary[i] = (c_ary[i-1] * 3 + 3**q_num) % DIV_NUM
      q_num += 1
    end
  end
  # pp c_ary

  1.upto(s.length) do |i|
    case s[i]
    when 'A','C'
      b_ary[i] = b_ary[i-1]
    when 'B'
      b_ary[i] = (b_ary[i-1] + c_ary[i-1]) % DIV_NUM
    when '?'
      b_ary[i] = (b_ary[i-1] * 3 + c_ary[i-1]) % DIV_NUM
    end
  end
  # puts "B ==="
  # pp b_ary

  2.upto(s.length) do |i|
    case s[i]
    when 'B','C'
      a_ary[i] = a_ary[i-1]
    when 'A'
      a_ary[i] = (a_ary[i-1] + b_ary[i-1]) % DIV_NUM
    when '?'
      a_ary[i] = (a_ary[i-1] * 3 + b_ary[i-1]) % DIV_NUM
    end
  end
  # puts "A ==="
  # pp a_ary

  puts a_ary[-1] % DIV_NUM
end

if __FILE__ == $0
  main
end
