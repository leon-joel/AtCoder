require 'pp'

def gets; ARGF.gets; end

def main
  s = gets.chomp
  s_digit = s.length

  upper = s.to_i

  ans = 0
  3.upto(s_digit) do |digit|
    if digit < s_digit
      ans += count_75s(false, false, false, digit)
    else
      # 桁数がMAXの場合
      ans += create_75s(s, false, false, false, digit)
    end

  end

  puts ans
end

def count_75s(u3, u5, u7, digit)
  if digit == 1
    case [u3, u5, u7]
    when [true, true, true]
      3
    when [true, true, false], [true, false, true], [false, true, true]
      1
    else
      0
    end
  elsif digit == 2
    case [u3, u5, u7]
    when [true, true, true]
      9
    when [true, true, false], [true, false, true], [false, true, true]
      4
    when [true, false, false], [false, true, false], [false, false, true]
      2
    else
      0
    end
  else
    cnt = count_75s(true, u5, u7, digit-1) +
        count_75s(u3, true, u7, digit-1) +
        count_75s(u3, u5, true, digit-1)
    cnt
  end
end

def create_75s(s, u3, u5, u7, digit)
  ux = s[s.length - digit].to_i
  if digit == 1
    if !u3
      if ux < 3
        0
      else
        1
      end
    elsif !u5
      if ux < 5
        0
      else
        1
      end
    elsif !u7
      if ux < 7
        0
      else
        1
      end
    else
      if ux < 3
        0
      elsif ux < 5
        1
      elsif ux < 7
        2
      else
        3
      end
    end
  else
    cnt = 0
    if 7 < ux
      cnt += count_75s(u3, u5, true, digit-1)
    elsif 7 == ux
      cnt += create_75s(s, u3, u5, true, digit-1)
    end
    if 5 < ux
      cnt += count_75s(u3, true, u7, digit-1)
    elsif 5 == ux
      cnt += create_75s(s, u3, true, u7, digit-1)
    end
    if 3 < ux
      cnt += count_75s(true, u5, u7, digit-1)
    elsif 3 == ux
      cnt += create_75s(s, true, u5, u7, digit-1)
    end
    cnt
  end
end



if __FILE__ == $0
  main
end
