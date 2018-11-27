require 'pp'

def gets; ARGF.gets; end

def main
  n = gets.chomp.to_i
  d_ary = []
  c_ary = []
  # M の累積和
  m_num = 0
  m_acum = Array.new(n)
  gets.chomp.each_char.with_index do |c, i|
    if c == "D"
      d_ary << i
    elsif c == "C"
      c_ary << i
    elsif c == "M"
      m_num += 1
    end
    m_acum[i] = m_num
  end
  puts "D: #{d_ary}"
  puts "C: #{c_ary}"
  puts "#{m_acum}"

  q = gets.chomp.to_i
  gets.split.each do |k|

  end

end

if __FILE__ == $0
  main
end
