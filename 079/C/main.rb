def main
  a, b, c, d = ARGF.gets.chars.map(&:to_i)

  s = if a+b+c+d == 7
        "#{a}+#{b}+#{c}+#{d}=7"
      elsif a+b+c-d == 7
        "#{a}+#{b}+#{c}-#{d}=7"
      elsif a+b-c+d == 7
        "#{a}+#{b}-#{c}+#{d}=7"
      elsif a+b-c-d == 7
        "#{a}+#{b}-#{c}-#{d}=7"
      elsif a-b+c+d == 7
        "#{a}-#{b}+#{c}+#{d}=7"
      elsif a-b+c-d == 7
        "#{a}-#{b}+#{c}-#{d}=7"
      elsif a-b-c+d == 7
        "#{a}-#{b}-#{c}+#{d}=7"
      elsif a-b-c-d == 7
        "#{a}-#{b}-#{c}-#{d}=7"
      else
        "error"
      end
  puts s
end

if __FILE__ == $0
  main
end
